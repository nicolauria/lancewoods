// validate billing address before submit
function isValidated(elements, captcha) {
    var results, errors = 0;

    if (elements.length) {
        for (var j = 0; j < elements.length; j++) {

            var $input = $(elements[j]);
            if ((results = $input.regula('validate')).length) {
                for (k = 0; k < results.length; k++) {
                    errors++;
                    $input.siblings(".form-validation").text(results[k].message).parent().addClass("has-error");
                }
            } else {
                $input.siblings(".form-validation").text("").parent().removeClass("has-error")
            }
        }

        if (captcha) {
            if (captcha.length) {
                return validateReCaptcha(captcha) && errors === 0
            }
        }

        return errors === 0;
    }
    return true;
}

// purchase items submits ba and sa forms
$('#purchase-items').on('click', function(event) {
    event.preventDefault()

    var elements = [
        $('#checkout-first-name-1'),
        $('#checkout-last-name-1'),
        $('#checkout-company-1'),
        $('#checkout-address-1'),
        $('#checkout-city-1'),
        $('#checkout-email-1'),
        $('#checkout-phone-1')
    ]

    if (isValidated(elements)) {
        console.log('validated')
    } else {
        console.log('not validated')
    }

    // if ($('#billing-shipping-same').is(':checked')) {
    //     $('#billing-address')[0].submit()
    // } else {
    //     // append all sa inputs to ba form
    //     $('#billing-address').append($('#checkout-first-name-2'))
    //     $('#billing-address').append($('#checkout-last-name-2'))
    //     $('#billing-address').append($('#checkout-company-2'))
    //     $('#billing-address').append($('#checkout-address-2'))
    //     $('#billing-address').append($('#checkout-city-2'))
    //     $('#billing-address').append($('#checkout-email-2'))
    //     $('#billing-address').append($('#checkout-phone-2'))

    //     $('#billing-address')[0].submit()
    // }
    
})