module ErrorsHelper
  def instance_error_messages!(object)
    return "" unless errors?(object)
    html = ''
    messages_hash = object.errors.messages
    keys = messages_hash.keys
    keys.each do |key|
      html += "<h5>#{key}</h5>"
      messages_arr = messages_hash[key]
      messages_arr.each do |message|
        html += "<p>#{message}</p>"
      end
    end

    html.html_safe
  end

  def errors?(object)
    object.errors.messages.length >= 1
  end
end
