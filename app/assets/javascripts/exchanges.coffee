$(document).ready ->

  # não é necessário
  # $('form').submit ->
  #   if $('form').attr('action') == '/convert'
  #     goToExchange()

  $('#amount').change ->
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

  $('#btn-transfer').click ->
    source_currency_val = $("#source_currency").val()
    target_currency_val = $("#target_currency").val()
    $("#source_currency").val(target_currency_val)
    $("#target_currency").val(source_currency_val)
  return
