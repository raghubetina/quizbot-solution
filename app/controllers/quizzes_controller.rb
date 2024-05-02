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

  def show
    # {"the_id"=>"5"}

    q_id = params.fetch("the_id")

    all_matches = Quiz.all.where({ :id => q_id })

    @the_quiz = all_matches.at(0)

    render({ :template => "quiz_templates/details" })
  end
end
