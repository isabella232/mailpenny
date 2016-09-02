# <!-- BEGIN GENERATED ANNOTATION -->
# ## Schema Information
#
# Table name: `social_media_accounts`
#
# ### Columns
#
# Name              | Type               | Attributes
# ----------------- | ------------------ | ---------------------------
# **`id`**          | `integer`          | `not null, primary key`
# **`user_id`**     | `integer`          |
# **`platform`**    | `integer`          | `not null`
# **`username`**    | `string`           | `not null`
# **`url`**         | `string`           | `not null`
# **`proof`**       | `string`           |
# **`confirmed`**   | `boolean`          | `default(FALSE), not null`
# **`created_at`**  | `datetime`         | `not null`
# **`updated_at`**  | `datetime`         | `not null`
#
# ### Indexes
#
# * `index_social_media_accounts_on_user_id`:
#     * **`user_id`**
#
# ### Foreign Keys
#
# * `fk_rails_19f1549559`:
#     * **`user_id => users.id`**
#
# <!-- END GENERATED ANNOTATION -->

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
