module FlashHelper
  # displays flash messages
  def flash_messages!
    if flash[:notice]
      html = '<div class="ui positive message">
              <p>' +
                flash[:notice] +
              '</p>
            </div>'

      html.html_safe
    end

  end
end
