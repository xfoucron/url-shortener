# frozen_string_literal: true

class IpAddressValidator < ActiveModel::EachValidator
  def validate_each(_record, _attribute, value)
    IPAddr.new(value)
  rescue StandardError => _e
    false
  end
end
