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

# Social media accounts for the users
class SocialMediaAccount < ApplicationRecord
  after_initialize :set_defaults

  belongs_to :user

  validates :platform,
            presence: true,
            uniqueness: {
              scope: :user,
              message: 'You have already registered an account from that ' \
              'platform'
            }
  validates :platform, presence: true
  validates :username, presence: true
  validates :url, presence: true

  enum platform: {
    twitter:   1,
    facebook: 2,
    linkedin: 3
  }

  private

  def set_defaults
    # sanitize the username
    self.username = username.strip

    case platform
    when 'twitter'
      self.url = "https://twitter.com/#{username}"
    when 'facebook'
      self.url = "https://facebook.com/#{username}"
    end
  end

  # hide the setter for confirmed
  def confirmed=(value)
    self[:confirmed] = value
  end
end
