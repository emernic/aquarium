function SequenceEditor() {
}

SequenceEditor.prototype.init = function(id) {

  var se = this;

  $.ajax({
    method: "GET",
    url: "/sequences/" + id + ".json"
  }).done(function(data) {
    se.data = data;    
    se.setup();
  });

}

SequenceEditor.prototype.raw_bases = function() {

  var n = this.data.sequence_versions.length,
      blist = this.data.sequence_versions[n-1].data.split("");

  blist.push("&nbsp;");
  return blist;

}

SequenceEditor.prototype.setup = function() {

  var se = this;

  this.bases = [];

  $('#sequence').empty();
  $('body').keyup(this.keypress());

  aq.each(this.raw_bases(),function(b,i) {
    var base = new Base(b,i,se.click());
    se.bases.push(base);
    $('#sequence').append(base.element);
  });

}

SequenceEditor.prototype.render = function() {

  var se = this;

  $('#begin').empty().html(this.begin);
  $('#end').empty().html(this.end);

  aq.each(se.bases,function(base,i) {

    if ( !se.end ) {
      base.select(i == se.begin);
    } else {
      if ( se.begin <= se.end ) {
        base.select( se.begin <= i && i <= se.end );
      } else {
        base.select( se.end <= i && i <= se.begin );
      }
    }

  });

}

SequenceEditor.prototype.click = function() {

  var se = this;

  return function(e) {

    if (e.shiftKey) {
      se.end = $(this).data("index");
    } else {
      se.begin = $(this).data("index");
      se.end = undefined; 
    }

    se.render();

  }

}

SequenceEditor.prototype.reindex = function() {
  aq.each(this.bases, (b,i) => b.reindex(i) );
}

SequenceEditor.prototype.keypress = function() {

  var se = this;
  var base_chars = [ "a", "t", "c", "g", "A", "T", "C", "G", "n", "N" ];

  return function(e) {

    if ( se.begin > se.end ) {
      se.begin = se.end;
    }
    se.end = undefined;

    if ( base_chars.indexOf(e.key) >= 0 ) {

      var b = new Base(e.key,se.begin,se.click);
      b.insert_before(se.bases[se.begin]);
      se.bases.splice(se.begin,0,b);
      
      se.reindex();
      se.begin = b.index + 1;

      se.render();

    } else if ( e.keyCode == 8 && se.begin > 0 /* DELETE */ ) {

      se.bases[se.begin-1].element.remove();
      se.bases.splice(se.begin-1,1);
      se.begin--;
      se.reindex();
      se.render();

    } else if ( e.keyCode == 37 && se.begin > 0 ) {
      se.begin--;
      se.render();
    } else if ( e.keyCode == 39 && se.begin < se.bases.length ) {
      se.begin++;
      se.render();
    }

  }

}
