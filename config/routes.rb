Rails.application.routes.draw do
  # /quizzes - list of all quizzes
  get("/quizzes", { :controller => "quizzes", :action => "index" })

  post("/insert_quiz", { :controller => "quizzes", :action => "create" })

  # /quizzes/42 - details of one quiz

  get("/quizzes/:the_id", { :controller => "quizzes", :action => "show" })
end
