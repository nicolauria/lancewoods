$('#purchase-items').on('click', function(event) {
    event.preventDefault()
    
    if ($('#billing-shipping-same').is(':checked')) {
        $('#billing-address').submit(function(response) {
            console.log(response);
        })
    } else {
        $('#billing-address').submit(function(event) {
            console.log(event);
        })
    }
    
})