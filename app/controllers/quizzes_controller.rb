class QuizzesController < ApplicationController
  def index

    render({ :template => "quiz_templates/list" })
  end
end
