# == Schema Information
#
# Table name: quizzes
#
#  id         :integer          not null, primary key
#  topic      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Quiz < ApplicationRecord
end
