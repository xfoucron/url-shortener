# frozen_string_literal: true

class Impression < ApplicationRecord
  belongs_to :link

  validates :link, presence: true
  validates :ip_address, presence: true, ip_address: true
end
