SecureHeaders::Configuration.default do |config|
  config.csp = {
    report_only: !Rails.env.production?, # default: false
    preserve_schemes: true, # default: false.


    default_src: %w('none'), # nothing allowed
    font_src: %w('self' fonts.gstatic.com),
    script_src: %w('self' www.google-analytics.com),
    connect_src: %w('self'),
    img_src: %w('self'),
    style_src: %w('unsafe-inline' 'self' fonts.googleapis.com,),
    report_uri: ['https://payload.report-uri.io/r/default/csp/enforce']
  }
end
