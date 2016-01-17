module LinkHelper
  def account_signed_in?
    return true if (user_signed_in? || admin_signed_in?)
  end

  def abbreviate(string)
    if string.length >= 45
      return string[0..45] + "..."
    end

    string
  end

  def ownership
  end
end
