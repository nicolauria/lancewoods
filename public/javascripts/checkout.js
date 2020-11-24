$(document).ready(function() {

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

    // Set your publishable key: remember to change this to your live publishable key in production
    // See your keys here: https://dashboard.stripe.com/account/apikeys
    var stripe = Stripe('pk_test_51HhQkDDo59FIWnSXxJendkY6xBMThmL4NHSsW1oagXIj6WzzJSbgO4G2GPapXza7Rtr6WqDQnVe3a2HxsPbd4OID00o6ZoLbdY');
    var elements = stripe.elements();

    // Custom styling can be passed to options when creating an Element.
    var style = {
        base: {
        // Add your base input styles here. For example:
        fontSize: '16px',
        color: '#32325d',
        },
    };

    // Create an instance of the card Element.
    var card = elements.create('card', {style: style});
    
    // Add an instance of the card Element into the `card-element` <div>.
    card.mount('#card-element');

    function stripeTokenHandler(token) {
        // Insert the token ID into the form so it gets submitted to the server
        var form = document.getElementById('payment-form');
        var hiddenInput = document.createElement('input');
        hiddenInput.setAttribute('type', 'hidden');
        hiddenInput.setAttribute('name', 'stripeToken');
        hiddenInput.setAttribute('value', token.id);
        form.appendChild(hiddenInput);
    
        // Submit the form
        form.submit();
    }

    // Create a token or display an error when the form is submitted.
    var form = document.getElementById('payment-form');
    form.addEventListener('submit', function(event) {
        event.preventDefault();

        var elements = [
            $('#checkout-first-name-1'),
            $('#checkout-last-name-1'),
            $('#checkout-company-1'),
            $('#checkout-address-1'),
            $('#checkout-city-1'),
            $('#checkout-email-1'),
            $('#checkout-phone-1')
        ]

        if (!isValidated(elements)) {
            $('#purchase-items').html('Purchase not submitted...')
            setTimeout(function() {
                $('#purchase-items').html('Purchase Items')
            })
            return
        }

        stripe.createToken(card).then(function(result) {
            if (result.error) {
            // Inform the customer that there was an error.
            var errorElement = document.getElementById('card-errors');
            errorElement.textContent = result.error.message;
            } else {
            // Send the token to your server.
            stripeTokenHandler(result.token);
            }
        });
    });
})