// purchase items submits ba and sa forms
$('#purchase-items').on('click', function(event) {
    event.preventDefault()

    if ($('#billing-shipping-same').is(':checked')) {
        $('#billing-address')[0].submit()
    } else {
        // append all sa inputs to ba form
        $('#billing-address').append($('#checkout-first-name-2'))
        $('#billing-address').append($('#checkout-last-name-2'))
        $('#billing-address').append($('#checkout-company-2'))
        $('#billing-address').append($('#checkout-address-2'))
        $('#billing-address').append($('#checkout-city-2'))
        $('#billing-address').append($('#checkout-email-2'))
        $('#billing-address').append($('#checkout-phone-2'))

        $('#billing-address')[0].submit()
    }
    
})