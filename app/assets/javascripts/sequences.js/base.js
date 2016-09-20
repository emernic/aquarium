function Base(base,index,click) {

  this.base = base;
  this.index = index;
  this.click = click;
  this.element = this.new_element();
  this.features = [];

}

Base.prototype.new_element = function() {

  return $("<span></span>")
    .html(this.base)
    .addClass("base")
    .data("index", this.index)
    .click(this.click);

}

Base.prototype.reindex = function(i) {
  this.index = i;
  this.element.data("index",i);
}

Base.prototype.select = function(selected) {

  if ( selected ) {
    this.element.addClass('base-selected');    
  } else {
    this.element.removeClass('base-selected');
  }

}

Base.prototype.insert_before = function(other_base) {
  this.element.insertBefore(other_base.element);
}
