$(document).ready ->

  # não é necessário
  # $('form').submit ->
  #   if $('form').attr('action') == '/convert'
  #     goToExchange()

  $('#source_currency').change ->
    goToExchange()
  
  $('#target_currency').change ->
    goToExchange()

  $('#amount').change ->
    goToExchange()

  $('#btn-transfer').click ->
    source_currency_val = $("#source_currency").val()
    target_currency_val = $("#target_currency").val()
    $("#source_currency").val(target_currency_val)
    $("#target_currency").val(source_currency_val)
    goToExchange()

  goToExchange = ->
    $.ajax '/convert',
          type: 'GET'
          dataType: 'json'
          data: {
                  source_currency: $("#source_currency").val(),
                  target_currency: $("#target_currency").val(),
                  amount: $("#amount").val()
                }
          error: (jqXHR, textStatus, errorThrown) ->
            alert textStatus
          success: (data, text, jqXHR) ->
            $('#result').val(data.value)
        return false; 

  
