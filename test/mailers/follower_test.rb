require 'test_helper'

class FollowerTest < ActionMailer::TestCase
  test "followers_update" do
    mail = Follower.followers_update
    assert_equal "Followers update", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
