class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # in case of guest

    can :create, Classroom
    can :manage, Classroom do |classroom|
      classroom.users.where(roles: {role: :teacher}).include? user
    end
    can :user_classrooms, Classroom do |classroom|
      classroom.users.where(roles: {role: :student}).include? user
    end
    
  end
end
