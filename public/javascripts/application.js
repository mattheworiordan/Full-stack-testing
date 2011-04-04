$(document).ready(function() {
  if ($(document).find('#calculator').length) {
    // set up the Javascript calculator methods
    var calculator = new Calculator();
    $('<div id="numbers-container"><label>Numbers</label><div class="buttons"></div>').insertAfter('#modify-value-text-field-area');
    calculator.insertNumericButtonsIntoDom($('#numbers-container .buttons'));
    calculator.insertOperationButtonsIntoDom($('#calculator .actions'));

    var calculatorStorage = new CalculatorStorage('#memory-bank', '#calculator .value');
    calculatorStorage.setupDropTarget();

    // add a dialog box action to the C button so we can test this
    $('input[type=submit][value="C"]').click(function(event) {
      event.preventDefault();
      $('#dialog-confirm').dialog({
        resizable: false,
        height:140,
        modal: true,
        buttons: {
          'Yes': function() {
            $('form').append('<input type="hidden" name="method" value="C">');
            $('form').submit();
            $(this).dialog("close");
          },
          'Cancel': function() {
            $(this).dialog('close');
          }
        }
      });
      return (false);
    });

    // add a prompt so we can test this
    $('.operations input[type=submit]').click(function(event) {
      if ($('#calculator input[type=text]#modify_value').val() == 0) {
        if (!confirm('Are you sure you want to perform this operation on a zero value.  If not, press cancel and enter a value before performing an operation.')) {
          event.preventDefault();
        }
      }
    })
  }
})