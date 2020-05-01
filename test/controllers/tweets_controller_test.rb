require 'test_helper'

class TweetsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get tweets_index_url
    assert_response :success
    assert_select "title", "Tweet | ツイート一覧"
  end

  test "should get show" do
    get tweets_show_url
    assert_response :success
    assert_select "title", "Tweet | ツイート詳細"
  end

  test "should get edit" do
    get tweets_edit_url
    assert_response :success
    assert_select "title", "Tweet | ツイート編集"
  end

  test "should get new" do
    get tweets_new_url
    assert_response :success
    assert_select "title", "Tweet | 新規投稿"
  end

end
