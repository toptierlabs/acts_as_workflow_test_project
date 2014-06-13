class StaticPagesController < ApplicationController
  def index
    @users_collection = User.select(:id, :role)
      .collect{ |u| ["#{u.id} - #{u.role}", u.id] }
  end

  def show
  end
end

