class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    can :read, :all
    can [:robots, :privacy, :terms, :prelaunch, :why, :feedback], :pages
    can :create, Incident
    can :create, Witness
    can :create, Car

    if user.admin?
      can :manage, :all
      can [:edit_override_score, :update_override_score], Incident
    end

    if user.mod?
      can [:edit_override_score, :update_override_score], Incident

      can [:update, :destroy], Incident, user_id: user.id
      can [:update, :destroy], Car, incident: { user_id: user.id }
      can [:update, :destroy], Witness, incident: { user_id: user.id }
    end

    if user.id.present?
      can [:update, :destroy], Incident, user_id: user.id
      can [:update, :destroy], Car, incident: { user_id: user.id }
      can [:update, :destroy], Witness, incident: { user_id: user.id }
    end

    if user.id.nil?
      # TODO set permissions to allow edits of Incident, Car, and Witness entries
      # that that IP created for 5 minutes after the created_at date
    end
  end
end
