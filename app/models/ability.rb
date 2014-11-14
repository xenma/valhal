class Ability
  include CanCan::Ability
  include Hydra::Ability

  def create_permissions

    if user_groups.include?('Chronos-Alle')
      can [:create], Work
    end

    if (user_groups & ['Chronos-Pligtaflevering','Chronos-Admin']).present?
      can [:create], Instance
      can [:create], Trykforlaeg
    end
  end

  def custom_permissions
    can [:destroy], ActiveFedora::Base do |obj|
      test_edit(obj.pid)
    end

    can [:download], ContentFile do |cf|
      test_read(cf.pid)
    end
    if user_groups.include?('Chronos-Alle')
      can [:aleph], Work
    end
  end
end
