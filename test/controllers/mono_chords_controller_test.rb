require 'test_helper'

class MonoChordsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @base_title = "モノコード"
  end

  test "should get root" do
    get root_url
    assert_response :success
    assert_select "title", "モノコード"
  end

  test "should get home" do
    get mono_chords_home_url
    assert_response :success
    assert_select "title", "#{@base_title}"
  end

  test "should get help" do
    get mono_chords_help_url
    assert_response :success
    assert_select "title", "ヘルプ - #{@base_title}"
  end

  test "should get about" do
    get mono_chords_about_url
    assert_response :success
    assert_select "title", "モノコードとは - #{@base_title}"
  end

  test "should get privacy" do
    get mono_chords_privacy_url
    assert_response :success
    assert_select "title", "個人情報保護方針 - #{@base_title}"
  end

  test "should get terms" do
    get mono_chords_terms_url
    assert_response :success
    assert_select "title", "利用規約 - #{@base_title}"
  end

end
