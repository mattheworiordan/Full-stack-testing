function Calculator() {
  this.initialize = function() {
    // bind events to this object
    var calculator = this;
    $.each(['numericButtonPressed', 'rootPressed', 'squarePressed'], function(index, event) {
      calculator[event] = $.bind(calculator, calculator[event]);
    });
  }

  this.insertNumericButtonsIntoDom = function(target) {
    var buttons = [7,8,9,4,5,6,1,2,3,0];
    buttonHtml = $.map(buttons, function(buttonValue) {
      return ('<button>' + buttonValue + '</button>')
    }).join('');
    var buttons = $(buttonHtml).click(this.numericButtonPressed);
    target.append(buttons);
  }

  this.insertOperationButtonsIntoDom = function(target) {
    var hex = $('<button>√</button>').click(this.rootPressed);
    target.append(hex);
    var square = $('<button>x<sup>2</sup></button>').click(this.squarePressed)
    target.append(square);
  }

  this.numericButtonPressed = function(object, event) {
    event.preventDefault();
    var modifyValue = $('input[type=text]#modify_value');
    var newVal = modifyValue.val() + $(event.target).text();
    newVal = newVal.replace(/^0(\d+)$/, "$1"); // strip leading 0
    modifyValue.val(newVal);
  }

  this.rootPressed = function(object, event) {
    event.preventDefault();
    this.sendAjaxOperation('square root');
  }

  this.squarePressed = function(object, event) {
    event.preventDefault();
    this.sendAjaxOperation('squared');
  }

  this.sendAjaxOperation = function(operation) {
    var payLoad = {
      value: $.trim($('#calculator>.value').text()),
      method: operation,
      modify_value: $.trim($('#calculator input[type=text]#modify_value').val()),
      history:
        $.map($('#calculator>ul.history li'), function(historyItem) {
          return ($(historyItem).text());
        }).join('|')
    }
    // Default JSON-request options.
    var params = {
      url:          document.location.href,
      type:         'PUT',
      contentType:  'application/json',
      data:         JSON.stringify(payLoad),
      dataType:     'json',
      processData:  false,
      success:      function(data) {
        $('#calculator>.value').text(data.value);
        $('#calculator>ul.history li').remove();
        $.each(data.history, function(index, historyLine) {
          li = $('<li/>');
          li.text(historyLine);
          $('#calculator>ul.history').append(li);
        });
        $('#calculator input[type=hidden]#history').val(data.history.join('|'));
        $('#message-holder').html('');
      },
      error:        function(jqXHR, textStatus, errorThrown) {
        console.log(arguments);
        var message = 'A server error occured, sorry we could not perform this operation.';
        try {
          message = eval('a = ' + jqXHR.responseText).message;
        } catch (e) {
          // ignore if there is no JSON error message and use default message
          console.log(e);
        }
        $('#message-holder').html('<div class="flash-error">' + message + '</div>');
      }
    };
    $.ajax(params);
  }

  // these methods are only here so we can do some unit testing
  this.sum = function(val1, val2) {
    return (val1 + val2);
  }
  this.multiple = function(val1, val2) {
    return (val1 * val2);
  }

  this.initialize();
}