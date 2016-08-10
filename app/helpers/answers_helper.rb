module AnswersHelper
  def allow_ajax_only_if_user_is_signin_for_upvote(answer)
    if current_user.present?
      link_to  "<i class='chevron up  icon'></i>".html_safe, vote_answer_path(answer.id, value: 1), method: "post", remote: true, class: 'ui basic icon button vote'
    else
      link_to  "<i class='chevron up  icon'></i>".html_safe, vote_answer_path(answer.id, value: 1), method: "post", remote: true, class: 'ui basic call-modal icon button'
    end
  end

  def allow_ajax_only_if_user_is_signin_for_downvote(answer)
    if current_user.present?
      link_to  "<i class='chevron down  icon'></i>".html_safe, vote_answer_path(answer.id, value: -1), method: "post", remote: true, class: 'ui basic icon button vote'
    else
      link_to  "<i class='chevron down  icon'></i>".html_safe, vote_answer_path(answer.id, value: -1), method: "post", remote: true, class: 'ui call-modal basic icon button'
    end
  end
end
