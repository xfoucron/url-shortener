# frozen_string_literal: true

require 'application_system_test_case'

class LinksTest < ApplicationSystemTestCase
  setup do
    @link = links(:github_repo)
  end

  test 'visiting the index' do
    visit links_url
    assert_selector 'h1', text: 'Links'
  end

  test 'should create link' do
    visit links_url
    click_on 'Shorten link'

    fill_in 'Name', with: @link.name
    fill_in 'Original url', with: @link.original_url
    click_on 'Create Link'

    assert_text 'Link was successfully created.'
    click_on 'Links'
  end

  test 'should update Link' do
    visit link_url(@link)
    click_on 'Edit link', match: :first

    fill_in 'Name', with: @link.name
    click_on 'Update Link'

    assert_text 'Link was successfully updated.'
    click_on 'Links'
  end

  test 'should destroy Link' do
    visit link_url(@link)
    click_on 'Destroy link', match: :first

    assert_text 'Link was successfully destroyed.'
  end
end
