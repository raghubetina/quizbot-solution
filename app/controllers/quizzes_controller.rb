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

    user_message = Message.new
    user_message.quiz_id = q.id
    user_message.role = "user"
    user_message.content = "Can you assess my #{q.topic} proficiency?"
    user_message.save

    # create the first assistant response

    prior_messages = [
      { :role => "system", :content => system_message.content },
      { :role => "user", :content => user_message.content },
    ]

    client = OpenAI::Client.new(access_token: ENV.fetch("OPENAI_KEY"))

    api_response = client.chat(
      parameters: {
        model: "gpt-4-turbo",
        messages: prior_messages
      }
    )

    # pp api_response

    assistant_message = Message.new
    assistant_message.quiz_id = q.id
    assistant_message.role = "assistant"
    assistant_message.content = api_response.fetch("choices").at(0).fetch("message").fetch("content")
    assistant_message.save

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
