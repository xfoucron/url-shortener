# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Impression, type: :model do
  let(:link) { Link.create(name: 'My example link', url: 'https://example.com/example-page', slug: 'example') }
  subject { described_class.new(link: link, ip_address: '10.0.0.1') }

  describe 'validations' do
    it 'is valid with correct attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without a link' do
      subject.link = nil
      expect(subject).to_not be_valid
    end

    it 'is valid with an IPv6 address' do
      subject.ip_address = '000f:00f0:0f00:f000:000f:00f0:0f00:f000'
      expect(subject).to be_valid
    end

    it 'is not valid with an incorrect IP address' do
      subject.ip_address = 'a.b.c.d'
      expect(subject).to_not be_valid
    end
  end
end
