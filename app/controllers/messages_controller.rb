class MessagesController < ApplicationController
  def create
    m = Message.new
    m.role = "user"
    m.content = params.fetch("query_content")
    m.quiz_id = params.fetch("query_quiz_id")

    m.save

    redirect_to "/quizzes/#{m.quiz_id}"
  end
end
