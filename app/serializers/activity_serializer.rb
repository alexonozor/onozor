class AuthorSerializer < ActiveModel::Serializer
  attributes :id, :full_name, :slug, :avatar
  def full_name
    object.fullname
  end
end

class ActivitySerializer < ActiveModel::Serializer
  attributes :id, :user_id, :actor_id, :trackable, :trackable_type, :seen, :read, :read_at, :created_at, :reason
  belongs_to :user, key: :reciever, serializer: AuthorSerializer
  belongs_to :actor, key: :sender, serializer: AuthorSerializer

  def reason
    if object.trackable_type == "Comment"
      if object.trackable.commentable_type == "Answer"
        question = object.trackable.commentable.question
        question_owner = object.trackable.commentable.question.user.slice('id', 'first_name', 'last_name', 'slug', 'username')
        answer_owner = object.trackable.commentable.user.attributes.slice('id', 'first_name', 'last_name', 'slug', 'username')
        converted_question = question.slice('id', 'slug', 'name', 'user_id')
        { answer_owner: answer_owner, question_owner: question_owner, question: converted_question }
      else
        question = object.trackable.commentable
        user = question.user.attributes.slice('id', 'first_name', 'last_name', 'username', 'slug')
        converted_question = question.slice('id', 'slug', 'name', 'user_id')
        { user: user, question: converted_question }
      end
    elsif object.trackable_type == "Answer"
      question = object.trackable.question
      converted_question = question.slice('id', 'slug', 'name', 'user_id')
      { question: converted_question }
    elsif object.trackable_type == "QuestionVote"
      question = object.trackable.question
      converted_question = question.slice('id', 'slug', 'name', 'user_id')
      { question: converted_question }
    elsif object.trackable_type == "AnswerVote"
      answer = object.trackable.answer
      question = object.trackable.answer.question
      converted_question = question.slice('id', 'slug', 'name', 'user_id')
      { answer: answer.id, question: converted_question }
    elsif object.trackable_type == "Favourite"
      question = object.trackable.question
      converted_question = question.slice('id', 'slug', 'name', 'user_id')
      { question: converted_question }
    end
  end
end
