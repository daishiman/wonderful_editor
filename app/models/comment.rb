# == Schema Information
#
# Table name: comments
#
#  id          :bigint           not null, primary key
#  body        :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  articles_id :integer
#  users_id    :integer
#
class Comment < ApplicationRecord
end
