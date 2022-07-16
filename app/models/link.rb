# frozen_string_literal: true

class Link < ApplicationRecord
  before_validation :set_slug

  validates :slug, presence: true, uniqueness: { case_sensitive: true }
  validates :original_url, url: true

  def set_slug
    self.slug = SecureRandom.urlsafe_base64(12) if slug?.blank?
  end

  def display_name
    name.presence || original_url
  end

  def export_path
    Rails.application.routes.url_helpers.redirect_url(slug)
  end
end
