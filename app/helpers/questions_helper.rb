module QuestionsHelper
 def popular
   @popular = Question.popular
 end


 def allow_ajax_only_if_user_is_signin_for_upvote_question(question)
   if current_user.present?
     link_to  "<i class='chevron up  icon'></i>".html_safe, vote_question_path(question.id, value: 1), method: "post", remote: true, class: 'ui icon basic small button vote'
   else
     link_to  "<i class='chevron up  icon'></i>".html_safe, vote_question_path(question.id, value: 1), method: "post", remote: true, class: 'ui icon call-modal basic small button'
   end
 end

 def allow_ajax_only_if_user_is_signin_for_downvote_question(question)
   if current_user.present?
     link_to  "<i class='chevron down  icon'></i>".html_safe, vote_question_path(question.id, value: -1), method: "post",  remote: true, class: 'ui icon basic small button vote'
   else
     link_to  "<i class='chevron down  icon'></i>".html_safe, vote_question_path(question.id, value: -1), method: "post", remote: true, class: 'ui icon call-modal basic small button vote'
   end
 end

end
