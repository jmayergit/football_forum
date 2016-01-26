module LinkHelper
  def account_signed_in?
    return true if (user_signed_in? || admin_signed_in?)
  end

  def abbreviate(string, n)
    if string.length >= n
      return string[0..n] + "..."
    end

    string
  end

  def recent_topic(forum)
    if forum.topics.length > 0
      return forum.topics.last.subject
    end

    ""
  end

  def ownership
  end
end
