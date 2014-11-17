class TrykforlaegsController < InstancesController

  authorize_resource :work
  authorize_resource :trykforlaeg, :through => :work

  private

  def set_klazz
    @klazz = Trykforlaeg
  end
end