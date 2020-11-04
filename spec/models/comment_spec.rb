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
require "rails_helper"

RSpec.describe Comment, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
