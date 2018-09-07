class Favourite < ActiveRecord::Base
  belongs_to :user
  belongs_to :question, counter_cache: true

  validates_presence_of :user

  #schema
  #t.integer  "user_id"
  #t.integer  "question_id"
  #t.datetime "created_at"
  #t.datetime "updated_at"
end
