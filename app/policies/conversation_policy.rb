class ConversationPolicy < ApplicationPolicy
  def show?
    @record.users.include? @user
  end
  class Scope < Scope
    def resolve
      scope
    end
  end
end
