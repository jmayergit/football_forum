class ValueValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    approved_statuses = ["unsanctioned","sanctioned","banned","moderator"]
    unless approved_statuses.include?(value)
      record.errors[attribute] << "invalid status"
    end
  end
end
