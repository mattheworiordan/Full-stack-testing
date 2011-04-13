function CalculatorStorage(target, dragValue) {
  this.MAX_ITEMS = 10;
  this.target = $(target);
  this.dragValue = $(dragValue);

  this.initialize = function() {
    // bind events to this object
    var storage = this;
    $.each(['clearMemoryBank'], function(index, event) {
      storage[event] = $.bind(storage, storage[event]);
    });

    $('#memory-bank a#clear-memory-bank').click(this.clearMemoryBank);
    this.retrieveValues();
  }

  this.setupDropTarget = function() {
    var storage = this;
    this.dragValue.draggable()
    this.target.droppable({
      tolerance: 'touch',
      activeClass: 'active-for-drop',
      hoverClass: 'hover-for-drop',
      activate: function(event, ui) {
        storage.hitStorageArea = false;
      },
      drop: function(event, ui) {
        storage.storeValue($(ui.draggable).text());
        storage.target.find('ul').prepend('<li>' + $(ui.draggable).text() + '</li>');
        storage.target.find('ul li').each(function(index, elem) {
          if (index > storage.MAX_ITEMS-1) {
            $(elem).remove();
          }
        });
        storage.hitStorageArea = true;
        $(ui.draggable).hide().css('left',0).css('top',0).slideDown(100);
      },
      deactivate: function(event, ui) {
        if (storage.hitStorageArea == false) {
          $(ui.draggable).animate({ left: 0, top: 0 }, 250);
        }
      },
    });
  }

  this.storeValue = function(value) {
    var currentlyStored = ($.cookie('stored_values') ? $.cookie('stored_values').split('|') : []);
    currentlyStored.splice(0, 0, value)
    $.cookie('stored_values', currentlyStored.slice(0,this.MAX_ITEMS).join('|'), { expires: 30 });
    $('#memory-bank a#clear-memory-bank').show();
  }

  this.retrieveValues = function() {
    var storage = this;
    var currentlyStored = ($.cookie('stored_values') ? $.cookie('stored_values').split('|') : []);
    storage.target.find('ul li').remove();
    $.each(currentlyStored, function(index, elem) {
      storage.target.find('ul').append('<li>' + elem + '</li>');
    });
    if (currentlyStored.length > 0) {
      $('#memory-bank a#clear-memory-bank').show();
    } else {
      $('#memory-bank a#clear-memory-bank').hide();
    }
  }

  this.clearMemoryBank = function(object, event) {
    event.preventDefault();
    $.cookie('stored_values', '');
    this.retrieveValues();
  }

  this.initialize();
}