class EducationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  before_action :set_education, only: [:show]
  before_action :set_user_education, only: [:edit, :update, :destroy]

  # GET /educations
  # GET /educations.json
  def index
    # Get all the education objects belonging to the user.
    @educations = @user.educations
  end

  # GET /educations/1
  # GET /educations/1.json
  def show
  end

  # GET /educations/new
  def new
    @education = Education.new
  end

  # GET /educations/1/edit
  def edit
  end

  # POST /educations
  # POST /educations.json
  def create
    @education = current_user.educations.new(education_params)

    respond_to do |format|
      if @education.save
        format.html { redirect_to user_profile_path(@user), notice: 'Education was successfully created.' }
        format.json { render :show, status: :created, location: @education }
      else
        format.html { render :new }
        format.json { render json: @education.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /educations/1
  # PATCH/PUT /educations/1.json
  def update

    respond_to do |format|
      if @education.update(education_params)
        format.html { redirect_to user_profile_path(@user), notice: 'Education was successfully updated.' }
        format.json { render :show, status: :ok, location: @education }
      else
        format.html { render :edit }
        format.json { render json: @education.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /educations/1
  # DELETE /educations/1.json
  def destroy
    @education.destroy
    respond_to do |format|
      format.html { redirect_to user_profile_path(@user), notice: 'Education was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_education
      # Find the row in the educations table where the id column
      # is the id of the params id.
      @education = Education.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def education_params
      params.require(:education).permit(:school, :degree, :start_date, :end_date)
    end

    def set_user_education
      # Query the educations table and find the row where the user_id
      # is the same as the current user and the id is the id passed
      # in to the parameters.
      @education = current_user.educations.find_by_id(params[:id])

      if @education == nil
        redirect_to user_profile_path(@user), flash: { alert: "You do not own this listing" }
      end
    end

    def set_user
      @user = User.find(params[:user_id])
    end
end
