module MailpennyHelper
  private

  # Returns the profile for the specified user
  # @param [user] the user whose profile path is required
  # @return [String] absolute path to the user's profile page
  def user_profile_path(user)
    "/#{user.username}"
  end
end
