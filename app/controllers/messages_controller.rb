class MessagesController < ApplicationController
  def create
    m = Message.new
    m.role = "user"
    m.content = params.fetch("query_content")
    m.quiz_id = params.fetch("query_quiz_id")

    m.save

    # Get the AI response

    prior_messages = Message.all.where({ :quiz_id => m.quiz_id })

    prior_message_hashes = []

    prior_messages.each do |a_message|
      message_hash = {
        :role => a_message.role,
        :content => a_message.content
      }

      prior_message_hashes.push(message_hash)
    end

    # pp prior_message_hashes

    client = OpenAI::Client.new(access_token: ENV.fetch("OPENAI_KEY"))

    api_response = client.chat(
      parameters: {
        model: "gpt-4-turbo",
        messages: prior_message_hashes
      }
    )

    assistant_message = Message.new
    assistant_message.quiz_id = m.quiz_id
    assistant_message.role = "assistant"
    assistant_message.content = api_response.fetch("choices").at(0).fetch("message").fetch("content")
    assistant_message.save

    redirect_to "/quizzes/#{m.quiz_id}"
  end
end
