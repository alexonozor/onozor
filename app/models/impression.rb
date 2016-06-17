class Impression < ActiveRecord::Base
	scope :today, -> {where("created_at >= ? AND created_at < ?", Time.now.beginning_of_day, Time.now.end_of_day)}
	scope :yesterday, -> {where("created_at >= ? AND created_at < ?", 1.day.ago.beginning_of_day, 1.day.ago.end_of_day)}
	scope :this_month, -> {where("created_at >= ? AND created_at < ?", Time.now.beginning_of_month, Time.now.end_of_month)}
end