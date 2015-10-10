module AnswersHelper
  def allow_ajax_only_if_user_is_signin_for_upvote(question)
    if current_user.present?
      link_to  "Upvote | <span id='vote-count-#{question.id}'>#{question.votes}</sapn>".html_safe, vote_question_path(question.id, value: 1), method: "post", remote: true, class: 'btn btn-secondry btn-sm'
    else
      link_to  "Upvote | <span id='vote-count-#{question.id}'>#{question.votes}</sapn>".html_safe, vote_question_path(question.id, value: 1), method: "post", class: 'btn btn-secondry btn-sm'
    end
  end

  def allow_ajax_only_if_user_is_signin_for_downvote(question)
    if current_user.present?
      link_to  "Downvote", vote_question_path(question.id, value: -1), method: "post", remote: true
    else
      link_to  "Downvote", vote_question_path(question.id, value: -1), method: "post"
    end
  end
end
