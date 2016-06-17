module AnswersHelper
  def allow_ajax_only_if_user_is_signin_for_upvote(question)
    if current_user.present?
      link_to  "<i class='fa fa-thumbs-up'></i>".html_safe, vote_question_path(question.id, value: 1), method: "post", remote: true, class: 'up-button'
    else
      link_to  "<i class='fa fa-thumbs-up'></i>".html_safe, vote_question_path(question.id, value: 1), method: "post", class: 'up-button'
    end
  end

  def allow_ajax_only_if_user_is_signin_for_downvote(question)
    if current_user.present?
      link_to  "<i class='fa fa-thumbs-down'></i>".html_safe, vote_question_path(question.id, value: -1), method: "post", remote: true, class: 'down-button'
    else
      link_to  "<i class='fa fa-thumbs-down'></i>".html_safe, vote_question_path(question.id, value: -1), method: "post", class: 'down-button'
    end
  end
end
