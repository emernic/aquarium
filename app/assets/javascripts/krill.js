function Krill(job,path,pc) {

    var that = this;

    this.steps_tag       = $('#steps');                               // element where step list should be put
    this.history_tag     = $('#history');
    this.inventory_tag   = $('#inventory');
    this.job = job;
    this.path = path;
    this.pc = pc;

    this.step_list = [];                                              // list of all step tags for easy access
    this.step_list_tag = $('<ul id="step_list"></ul>').addClass('krill-step-list');  // document ul containing step tags

}

Krill.prototype.update = function() {

    this.add_latest_step();
    this.info();
    this.history();
    this.inventory();

}

Krill.prototype.initialize = function() {

    // First, initialize the steps list
    this.steps_tag.append(this.step_list_tag);
    this.get_state();

    // keep track of step number
    var n=1;

    // Check that the Krill server has responded
    if ( this.state.length % 2 != 0 ) {
	   console.log ( "Server response not ready. "
             + "Tell your lead programmer to do a better job at multi-process control. "
             + "While you are waiting for him to fix this problem, try reloading the page." );
    }

    // Go through each step and add it to the display
    // The state looks like [ initialize, display, next, display, next, ..., display, next, complete|error ]
    //                        0           1        2     3        4          2n+1     2n+2  2n+3
    for ( var i=1; i<this.state.length; i += 2 ) {

        // Make an html element to containt the content
        var content = this.step(this.state[i],n);

        // Put the content in an li
        var s = $('<li id="l'+n+'"></li>')
        .addClass('krill-step-list-item')
        .append($('<div></div>')
            .addClass('krill-step-container')
            .append(content));

        // Add the content into the document and a separate list of tags for easy access
        this.step_list.push(s);
        this.step_list_tag.append(s);

        // Disable steps that have already been performed
        if ( i < this.state.length-2 ) {
           this.disable_step(s,this.state[i+1].inputs);
        }

        // Increment step number
        n++;

    }

    // Then render the history and inventory
    this.info();
    this.history();
    this.inventory();

    // Set up the carousel
    this.carousel_setup();
    this.resize();
    this.carousel_last();

}

Krill.prototype.disable_step = function(step,user_input) {

    step.addClass('krill-step-disabled');

    var inputs = $(".krill-input-box",step);

    for ( var i=0; i<inputs.length; i++ ) {
        inputs[i].disabled = true;
        $(inputs[i]).val(user_input[$(inputs[i]).attr('id')]);
    }

    var selects = $(".krill-select",step);

    for ( var i=0; i<selects.length; i++ ) {
        selects[i].disabled = true;
        $(selects[i]).val(user_input[$(selects[i]).attr('id')]);
    }

    $(".krill-next-btn",step).addClass('krill-next-btn-disabled');
    $(".krill-next-btn",step)[0].disabled = true;

}

Krill.prototype.add_latest_step = function() {

    var last = this.state.length-1;

    // Disable previous step
    this.disable_step(this.step_list[this.step_list.length-1],this.state[last-1].inputs);

    // Build last step
    var current = this.state[last];
    var content = this.step(current,(last+1)/2);

    // Add last step to lists
    var s = $('<li></li>').addClass('krill-step-list-item').append($('<div></div>').addClass('krill-step-container').append(content));
    s.css('width',$('#krill-steps-ui').outerWidth()-102).css('height', window.innerHeight - 90);
    this.step_list.push(s);
    this.step_list_tag.append(s);

}

Krill.prototype.build_titlebar = function(number,with_button) {  

    var that = this;

    var titlebar = $('<div></div>').addClass('row-fluid').addClass('krill-step-titlebar');
    var num = $('<div>' + (number) + '</div>').addClass('krill-step-number').addClass('span2');
    var title = $('<div></div>').addClass('krill-title').addClass('span8').attr('id','title');
    var btnholder = $('<div></div>').addClass('span2');

    if(with_button) {

        btn = $('<button id="next">OK</button>').addClass('krill-next-btn');
        btnholder.append(btn);

        btn.click(function() {
          that.send_next();
          that.update();
          that.carousel_inc(1);
        });

    }

    titlebar.append(num,title,btnholder);

    return titlebar;

}

Krill.prototype.log_link = function() { 

    var that = this;

    var btn = $('<button>View Log</button>').addClass('btn').click(function(){
        window.location = 'log?job=' + that.job;
    });

    return $('<li \>').append(btn).addClass('krill-note');

}

Krill.prototype.pending_link = function() { 

    var that = this;

    var btn = $('<button>View Pending Jobs</button>').addClass('btn').click(function(){
        window.location = '/jobs';
    });

    return $('<li \>').append(btn).addClass('krill-note');

}

Krill.prototype.step = function(state,number) {    

    var container = $('<div></div>').addClass('krill-step');

    if ( !state ) {

        return;

    } else if ( state.operation == 'display' ) {

        var description = state.content;
        var titlebar = this.build_titlebar(number,true);
        var ul = $('<ul></ul').addClass('krill-step-ul');

        for(var i=0; i<description.length; i++) {

            var key = Object.keys(description[i])[0];
            if ( this[key] ) {
              var new_element = this[key](description[i][key],$('#title',titlebar));
              if ( new_element ) {
                ul.append(new_element);
              }
            } else {
              ul.append('<li>Unknown display request <b>'+key+'</b>: '+JSON.stringify(description[i][key])+'</li>');
            }

        }

        container.append(titlebar,ul).css('width',$('#krill-steps-ui').outerWidth());
        container.css('width',$('#krill-steps-ui').outerWidth()-102);
        container.css('height', window.innerHeight - 90 );

    } else if ( state.operation == 'error' ) {

        this.pc = -2;

        var titlebar = this.build_titlebar("!",false);
        $('#title',titlebar).html('Error');

        var ul = $('<ul></ul>').addClass('krill-step-ul');
        var p = $('<li><b>'+state.message+'</b></li>').addClass('krill-warning');

        ul.append(p);

        $.each(state.backtrace,function(el) {
            var line_info = state.backtrace[el].replace('(eval):', 'line: ');
            ul.append($('<li>'+line_info+'</li>').addClass('krill-note'));
        });

        ul.append(this.log_link(),this.pending_link());
        container.append(titlebar,ul);

    } else {

        this.pc = -2;

        var titlebar = this.build_titlebar("&#9734;",false);
        $('#title',titlebar).html('Completed');

        var ul = $('<ul></ul>').addClass('krill-step-ul');
        var p = $('<li>This protocol completed normally.</li>').addClass('krill-note');

        ul.append(p);
        ul.append(this.log_link(),this.pending_link());

        container.append(titlebar,ul);

    }

    var that = this;
    container.on("swipeleft", function(){that.carousel_inc(1)});  
    container.on("swiperight",function(){that.carousel_inc(-1)});  

    return container;

}

Krill.prototype.item_li = function(item) {

  var li = $('<li>')
    .append("<span class='krill-inventory-item-id'>"+item.id+"</span>")
    .append("<span class='krill-inventory-object-type-name'>" 
        + item.object_type.name + "</span>");

  if ( item.sample_id ) { 
    li.append("<span class='krill-inventory-sample-name'>"
        + item.sample.name + "</span>");
  }

  li.click(function() {
    window.location = '/items/' + item.id;
  });

  return li;

}

Krill.prototype.inventory = function() {

    var that = this;

    $.ajax({

        url: 'inventory?job=' + that.job,

    }).done(function(data){

        var ul = $('<ul></ul>').addClass('krill-inventory-list');
        for ( var i in data.takes ) {
            ul.append(that.item_li(data.takes[i]));
        }

    	that.inventory_tag.empty().append($('<h4>In Use</h4>').addClass('krill-inventory-h4')).append(ul);

        if ( data.takes.length == 0 ) {
            that.inventory_tag.append("<p>None</p>").addClass('krill-inventory-none');
        }

        var ul = $('<ul></ul>').addClass('krill-inventory-list');

        for ( var i in data.touches ) {
            ul.append(that.item_li(data.touches[i]));
        }

        that.inventory_tag.append($('<h4>Used</h4>').addClass('krill-inventory-h4')).append(ul);

        if ( data.touches.length == 0 ) {
            that.inventory_tag.append("<p>None</p>").addClass('krill-inventory-none');
        }

    });

}


//////////////////////////////////////////////////////////////////////////////////////////
// PROCESS INPUTS
//

Krill.prototype.get = function() {

    // Returns an object containing the values of the inputs, if any

    var inputs = $(".krill-input-box",this.step_list[this.step_list.length-1]);
    var selects = $(".krill-select",this.step_list[this.step_list.length-1]);
    var values = { timestamp: Date.now()/1000 };

    $.each(inputs,function(i,e) {
        var name = $(e).attr("id");
        if($(e).attr("type")=="number") {
            values[name] = parseFloat($(e).val());
        } else {
            values[name] = $(e).val();
        }
    });

    $.each(selects,function(i,e) {
        var name = $(e).attr("id");
        values[name] = $(e).val();
    });

    return values;

}

/////////////////////////////////////////////////////////////////////////////////
// COMMUNICATION WITH RAILS
//

Krill.prototype.get_state = function() {

    var that = this;

    $.ajax({
        url: 'state?job=' + that.job,
        async: false
    }).done(function(data){
        that.state = data;
    }).fail(function(data){
        console.log("Error: " + data);
    });

}

Krill.prototype.send_next = function() {

    var inputs = this.get();
    var that = this;

    $.ajax({
        // type: "POST",
        url: 'next?job=' + that.job,
        data: { inputs: inputs },
        async: false
    }).done(function(data){
        that.state = data;
    }).fail(function(data){
        console.log("Error:"+data);
    });

}