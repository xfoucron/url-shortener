# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Link, type: :model do
  subject { Link.create(name: 'My example link', url: 'https://example.com/example-page', slug: 'example') }

  describe 'validations' do
    it 'is valid with correct attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without url' do
      subject.url = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid with a malformed url' do
      subject.url = 'ht_tp://malformed.url/?fhfh'
      expect(subject).to_not be_valid
    end

    it 'is not valid with a name bigger than 64 characters' do
      subject.name = '0' * 65
      expect(subject).to_not be_valid
    end

    it 'is not valid with a description bigger than 512 characters' do
      subject.description = '0' * 513
      expect(subject).to_not be_valid
    end

    it 'is valid with a generated slug' do
      subject.slug = nil
      expect(subject).to be_valid
    end
  end
end
