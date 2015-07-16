class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # in case of guest

    can :create, Classroom
    can :manage, Classroom do |classroom|
      classroom.users.where(roles: {role: :teacher}).include? user
    end
    can :show_classroom, Classroom do |classroom|
      classroom.users.where(roles: {role: :student}).include? user
    end
    can :manage, Exercise do |exercise|
      exercise.classroom.users.where(roles: {role: :teacher}).include? user
    end
    can :get_exercises, Exercise do |exercise|
      exercise.classroom.users.find(user.id)
    end
  end
end
