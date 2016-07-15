require 'restricted_usernames'

# People using the app
class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :validatable, :confirmable, :lockable,
         :timeoutable

  validates :username,
            presence: true,
            uniqueness: { case_sensitive: false },
            format: { with: /\A[a-zA-Z0-9_.-]+\Z/ },
            exclusion: {
              in: RestricedUsernamesIdentifier.new.initial_path_segments,
              message: 'Username unavailable'
            }
end
