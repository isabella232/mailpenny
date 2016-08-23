# == Schema Information
#
# Table name: social_media_accounts
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  platform   :integer          not null
#  username   :string           not null
#  url        :string           not null
#  proof      :string
#  confirmed  :boolean          default(FALSE), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe SocialMediaAccount, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
