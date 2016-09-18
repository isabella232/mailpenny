SecureHeaders::Configuration.default do |config|
  config.csp = {
    report_only: !Rails.env.production?, # default: false
    preserve_schemes: true, # default: false.


    default_src: %w('none'), # nothing allowed
    font_src: %w('self' fonts.gstatic.com *.intercom.io *.intercomcdn.com),
    script_src: %w('self' www.google-analytics.com *.intercom.io *.intercomcdn.com),
    connect_src: %w('self' wss://*.intercom.io *.intercom.io *.intercomcdn.com),
    img_src: %w('self' www.google-analytics.com),
    style_src: %w('unsafe-inline' 'self' fonts.googleapis.com,),
    report_uri: ['https://payload.report-uri.io/r/default/csp/enforce']
  }
end
