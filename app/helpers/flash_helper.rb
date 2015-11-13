module FlashHelper
  # displays flash messages of type notice or type alert
  def flash_messages!
    if flash[:notice]
      html = '<div class="flash ui opaque positive message">
                <i class="close icon"></i>' +
                  flash[:notice] +
                '</div>'

      html.html_safe
    elsif flash[:alert]
      html = '<div class="flash ui opaque negative message">
                <i class="close icon"></i>' +
                  flash[:alert] +
              '</div>'

      html.html_safe
    end
  end
end
