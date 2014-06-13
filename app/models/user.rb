class User < ActiveRecord::Base
  has_many :listings

  def role
    self[:role].to_sym
  end
end


