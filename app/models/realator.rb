class Realator
  include ActiveModel::Model
  attr_accessor :id, :name, :omg

  def initialize(attributes={})
    super
    @omg ||= true
  end
end