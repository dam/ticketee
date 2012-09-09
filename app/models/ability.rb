class Ability
  include CanCan::Ability
  
  #definition of can? cannot? with a white list
  def initialize(user)
    user.permissions.each do |permission|
      can permission.action.to_sym, permission.thing_type.constantize do |thing|
        thing.nil? || permission.thing_id.nil? || permission.thing_id == thing.id
      end
    end
  end
end
