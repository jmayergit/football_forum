class AssociationValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if value.blank?
      record.errors[attribute] << "#{record} must have a #{attribute}"
    end
  end
end
