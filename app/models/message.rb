# == Schema Information
#
# Table name: messages
#
#  id         :integer          not null, primary key
#  content    :text
#  role       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  quiz_id    :integer
#
class Message < ApplicationRecord
end
