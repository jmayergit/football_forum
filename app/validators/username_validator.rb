class UsernameValidator <  ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if /[^[[:alnum:]]]/.match(value)
      record.errors[attribute] << "contains invalid characters"
    end
  end
end
