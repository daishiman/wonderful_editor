# == Schema Information
#
# Table name: articles
#
#  id         :bigint           not null, primary key
#  body       :text
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  users_id   :integer
#
require "rails_helper"

RSpec.describe Article, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
