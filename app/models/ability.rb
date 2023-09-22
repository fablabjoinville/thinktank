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
    when :secretary
      can :read, :all

      can :manage, Company

      can :manage, Member

      can :manage, Person, authorization_level: [:person]
      can :read, Person, authorization_level: [:facilitator, :secretary, :admin, :super_admin]
    when :facilitator
      can :read, Cluster, person_id: user.id

      can :manage, Event, team: { clusters: { person_id: user.id }}
      can :create, Event

      # can :update, Person, id: user.id
      # can :read, Person, id: user.id

      can :read, Team, clusters: { person_id: user.id }

      can :read, User, id: user.id
      can :update, User, id: user.id
    end
  end
end
