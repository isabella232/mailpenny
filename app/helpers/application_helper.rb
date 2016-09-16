# The parent helper for all helpers
module ApplicationHelper
  def bootstrap_class_for(flash_type)
    case flash_type
    when 'success'
      'success' # Green
    when 'error'
      'danger' # Red
    when 'alert'
      'warning' # Yellow
    when 'notice'
      'info' # Blue
    else
      flash_type
    end
  end
end
