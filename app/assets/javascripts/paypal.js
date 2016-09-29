// Fetch the button you are using to initiate the PayPal flow
var paypalButton = document.getElementById('paypal-deposit-button');

// Get the token
$.get('/paypal/client_token', function(data) {
    // Create a Client component
    var paypalClientToken = data.token;
    braintree.client.create({
        authorization: paypalClientToken
    }, function(clientErr, clientInstance) {
        // Create PayPal component
        braintree.paypal.create({
            client: clientInstance
        }, function(err, paypalInstance) {
            paypalButton.addEventListener('click', function() {
                // Tokenize here!
                paypalInstance.tokenize({
                    flow: 'checkout', // Required
                    amount: 10.00, // Required
                    currency: 'USD', // Required
                    locale: 'en_US',
                    enableShippingAddress: true,
                    shippingAddressEditable: false,
                    shippingAddressOverride: {
                        recipientName: 'Scruff McGruff',
                        line1: '1234 Main St.',
                        line2: 'Unit 1',
                        city: 'Chicago',
                        countryCode: 'US',
                        postalCode: '60652',
                        state: 'IL',
                        phone: '123.456.7890'
                    }
                }, function(err, tokenizationPayload) {
                    // Tokenization complete
                    // Send tokenizationPayload.nonce to server
                    $.post("/paypal/checkout", {
                        payment_method_nonce: tokenizationPayload.nonce
                    });
                });
            });
        });
    });
});
