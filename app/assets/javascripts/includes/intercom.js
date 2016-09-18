var intercomAppId = $('div.hidden-user-information').data('intercom-app-id');
var userName = $('div.hidden-user-information').data('user-name');
var userEmail = $('div.hidden-user-information').data('user-email');
var userCreatedAt = $('div.hidden-user-information').data('user-created_at');

window.intercomSettings = {
    app_id: intercomAppId,
    name: userName, // Full name
    email: userEmail, // Email address
    created_at: userCreatedAt // Signup date as a Unix timestamp
};
var intercom = function() {
    var w = window;
    var ic = w.Intercom;
    if (typeof ic === "function") {
        ic('reattach_activator');
        ic('update', intercomSettings);
    } else {
        var d = document;
        var i = function() {
            i.c(arguments)
        };
        i.q = [];
        i.c = function(args) {
            i.q.push(args)
        };
        w.Intercom = i;

        function l() {
            var s = d.createElement('script');
            s.type = 'text/javascript';
            s.async = true;
            s.src = 'https://widget.intercom.io/widget/qvnmie0g';
            var x = d.getElementsByTagName('script')[0];
            x.parentNode.insertBefore(s, x);
        }
        if (w.attachEvent) {
            w.attachEvent('onload', l);
        } else {
            w.addEventListener('load', l, false);
        }
    }
};
intercom();
