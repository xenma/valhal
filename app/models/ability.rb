class Ability
  include CanCan::Ability
  include Hydra::Ability

  def create_permissions
    can [:create], ActiveFedora::Base do |obj|
      current_user
    end
    can [:aleph], Work do |w|
      current_user
    end
  end

  def custom_permissions
    can [:destroy], ActiveFedora::Base do |obj|
      test_edit(obj.pid)
    end

    can [:download], ContentFile do |cf|
      test_read(cf.pid)
    end
  end
end
