# frozen_string_literal: true

json.extract! link, :id, :name, :original_url, :slug, :created_at, :updated_at
json.url link_url(link, format: :json)
