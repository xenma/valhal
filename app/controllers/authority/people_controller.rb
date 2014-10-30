module Authority
  # Get most functionality from BasesController
  class PeopleController < Authority::BasesController
    # overwrite setter and whitelist

    private

    def set_klazz
      @klazz = Authority::Person
    end

    def authority_base_params
      params.require(:authority_person).permit(authorized_personal_name: [
        [:scheme, :full, :family, :given, :date]
      ])
    end
  end
end
