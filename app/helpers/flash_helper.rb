module FlashHelper
  # displays flash messages of type notice or type alert
  def flash_messages!
    if flash[:notice]
      html = '<div class="ui positive message">
              <p>' +
                flash[:notice] +
              '</p>
            </div>'

      html.html_safe
    elsif flash[:alert]
      html = '<div class="ui negative message">
              <p>' +
                flash[:alert] +
              '</p>
            </div>'

      html.html_safe
    end
  end
end
