# frozen_string_literal: true

class UrlValidator < ActiveModel::EachValidator
  def compliant?(value)
    uri = URI.parse(value)
    uri.is_a?(URI::HTTP) && !uri.host.nil?
  rescue URI::InvalidURIError
    false
  end

  def validate_each(record, attribute, value)
    record.errors.add(attribute, 'invalid') unless value.present? && compliant?(value)
  end
end
