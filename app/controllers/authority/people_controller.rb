module Authority
  # Get most functionality from BasesController
  class PeopleController < Authority::BasesController

    private

    def set_klazz
      @klazz = Authority::Person
    end
  end
end
