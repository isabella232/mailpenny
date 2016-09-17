module MailpennyHelper
  private

  # Returns the profile for the specified user
  # @param user [User] the user whose profile path is required
  # @return [String] absolute path to the user's profile page
  def user_profile_path(user)
    "/#{user.username}"
  end

  # Return the number of messages unread for the user
  # @param user [User] the user whose unread count you want
  # @return [Integer] the number of conversations still unread for this user
  def unread_count_for(user)
    user.conversations.select { |c| !c.read_by? user }.count
  end
end
