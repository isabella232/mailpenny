class MessagePolicy < ApplicationPolicy
  def create?
    # Is the user creating this message part of the conversation?
    @record.conversation.users.include?(@user)
  end
  class Scope < Scope
    def resolve
      scope
    end
  end
end
