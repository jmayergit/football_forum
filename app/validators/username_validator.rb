class UsernameValidator <  ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if /profanity/.match(value)
      record.errors[attribute] << "Username must not contain profanity"
    end
  end
end
