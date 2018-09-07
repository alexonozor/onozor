class AddUserAgentAndUserIpAndReferrerToAnswers < ActiveRecord::Migration
  def change
    add_column :answers, :user_agent, :string
    add_column :answers, :user_ip, :string
    add_column :answers, :referrer, :string
  end
end
