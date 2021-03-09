# frozen_string_literal: true

class Link < ApplicationRecord
  has_many :impressions, dependent: :delete_all

  validates :name, length: { maximum: 64 }
  validates :url, presence: true, format: URI::DEFAULT_PARSER.make_regexp(%w[http https]), length: { within: 3..512 }
  validates :slug, presence: true, uniqueness: true, length: { within: 3..32 }
  validates :description, length: { maximum: 512 }

  before_validation :generate_random_slug

  def generate_random_slug
    self.slug = SecureRandom.uuid[0..6] if slug.blank?
  end
end
