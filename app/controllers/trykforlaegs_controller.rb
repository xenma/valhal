class TrykforlaegsController < InstancesController

  load_and_authorize_resource :work
  load_and_authorize_resource :trykforlaeg, :through => :work

  private

  def set_klazz
    @klazz = Trykforlaeg
  end
end