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

    # create the system message

    system_message = Message.new
    system_message.quiz_id = q.id
    system_message.role = "system"
    system_message.content = "You are a #{q.topic} tutor. Ask the user five questions to assess their #{q.topic} proficiency. Start with an easy question. After each answer, increase or decrease the difficulty of the next question based on how well the user answered.

    In the end, provide a score between 0 and 10."
    system_message.save

    # create the first user message

    # create the first assistant response

    redirect_to "/quizzes/#{q.id}"
  end

  def show
    # {"the_id"=>"5"}

    q_id = params.fetch("the_id")

    all_matches = Quiz.all.where({ :id => q_id })

    @the_quiz = all_matches.at(0)

    render({ :template => "quiz_templates/details" })
  end
end
