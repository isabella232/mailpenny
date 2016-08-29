SecureHeaders::Configuration.default do |config|
  config.csp = {
    report_only: Rails.env.production?, # default: false
    preserve_schemes: true, # default: false.


    default_src: %w(‘none’), # nothing allowed
    font_src: %w('self' fonts.gstatic.com),
    script_src: %w('self'),
    connect_src: %w('self'),
    img_src: %w('self'),
    style_src: %w('unsafe-inline' 'self' fonts.googleapis.com,),
    report_uri: ["/csp_report?report_only=#{Rails.env.production?}"]
  }
end
