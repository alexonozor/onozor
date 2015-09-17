module QuestionsHelper
 def popular
   @popular = Question.popular
 end
  
end
