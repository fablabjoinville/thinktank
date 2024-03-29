# frozen_string_literal: true

# :manage
# read: [:index, :show]
# create: [:new, :create]
# update: [:edit, :update]
# destroy: [:destroy]

class Ability
  include CanCan::Ability

  def initialize(user)
    can :manage, ActiveAdmin::Page, name: "Dashboard"

    case user.authorization_level.to_sym
    when :super_admin
      can :manage, :all
    when :admin
      can :manage, :all

      cannot [:create, :update, :destroy], User, authorization_level: [:super_admin, :admin]
      can :update, User, id: user.id
    when :secretary
      can :read, :all

      can :manage, Company
      can :manage, Member

      can :manage, User, authorization_level: [:person]
      can :read, User, authorization_level: [:facilitator, :secretary, :admin, :super_admin]
      can :update, User, id: user.id

      cannot :manage, ActiveAdmin::Comment
      can :read, ActiveAdmin::Comment
    when :facilitator
      can :read, Cluster, user_id: user.id
      can :read, Team, cluster: { user_id: user.id }
      can :read, Member, team: { cluster: { user_id: user.id }}

      can :manage, Assessment, team: { cluster: { user_id: user.id }}
      can :manage, Attendance, team: { cluster: { user_id: user.id }}

      can :manage, Event, team: { cluster: { user_id: user.id }}
      can :create, Event

      can :read, User, id: user.id
      can :update, User, id: user.id
      cannot :index, User

      can :manage, ActiveAdmin::Comment
      cannot :destroy, ActiveAdmin::Comment do |comment|
        comment.author_id != user.id
      end
    end
  end
end
