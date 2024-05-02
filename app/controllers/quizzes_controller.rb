class QuizzesController < ApplicationController
  def index
    @list_of_quizzes = Quiz.all.order({ :created_at => :desc })

    render({ :template => "quiz_templates/list" })
  end

  def create
    # {"query_topic"=>"tennis"}

    q = Quiz.new
    q.topic = params.fetch("query_topic")
    q.save

    redirect_to "/quizzes"
  end
end
