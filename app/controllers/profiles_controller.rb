class ProfilesController < ApplicationController

  def show
    @education_history = Education.all
    @employment_history = Employment.all
  end

  def edit

  end

end