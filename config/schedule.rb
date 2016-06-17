set :output, {:error => 'error.log', :standard => 'cron.log'}

every :sunday, :at => '12pm' do
  runner "Question.news_letter_mailer"
  # rake "my:rake:task"
  command "/usr/bin/onozor_news_letter"
end

every :reboot do
  rake "log:clear"
end