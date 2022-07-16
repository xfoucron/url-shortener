# frozen_string_literal: true

require 'test_helper'

class LinkTest < ActiveSupport::TestCase
  def setup
    @link = links(:github_repo)
  end

  test 'should be saved' do
    assert_predicate(@link, :valid?)
  end

  test 'should not save link without original_url' do
    @link.original_url = nil

    assert_not_predicate(@link, :valid?)
    assert_not_predicate(@link.errors[:original_url], :nil?)
  end

  test 'should not save link if slug is duplicated' do
    assert @link.save
    assert_not @link.dup.save
  end
end
