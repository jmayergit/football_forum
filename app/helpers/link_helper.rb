module LinkHelper
  def account_signed_in?
    return true if (user_signed_in? || admin_signed_in?)
  end

  def abbreviate(string)
    return string[0...45] + "..."
  end

  def ownership
  end
end
