SecureHeaders::Configuration.default do |config|
  config.csp = {
    report_only: Rails.env.production?, # default: false
    preserve_schemes: true, # default: false.


    default_src: %w(‘none’), # nothing allowed
    script_src: %w(cdn.example.com),
    connect_src: %w('self'),
    img_src: %w(cdn.example.com),
    style_src: %w('unsafe-inline' cdn.example.com),
    report_uri: ["/csp_report?report_only=#{Rails.env.production?}"]
  }
end
