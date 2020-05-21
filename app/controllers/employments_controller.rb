class EmploymentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  before_action :set_employment, only: [:show]
  before_action :set_user_employment, only: [:edit, :update, :destroy]

  # GET /employments
  # GET /employments.json
  def index
    @employments = @user.employments
  end

  # GET /employments/1
  # GET /employments/1.json
  def show
  end

  # GET /employments/new
  def new
    @employment = Employment.new
  end

  # GET /employments/1/edit
  def edit
  end

  # POST /employments
  # POST /employments.json
  def create
    @employment = current_user.employments.create(employment_params)

    respond_to do |format|
      if @employment.save
        format.html { redirect_to user_profile_path(@user), notice: 'Employment was successfully created.' }
        format.json { render :show, status: :created, location: @employment }
      else
        format.html { render :new }
        format.json { render json: @employment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /employments/1
  # PATCH/PUT /employments/1.json
  def update
    respond_to do |format|
      if @employment.update(employment_params)
        format.html { redirect_to user_profile_path(@user), notice: 'Employment was successfully updated.' }
        format.json { render :show, status: :ok, location: @employment }
      else
        format.html { render :edit }
        format.json { render json: @employment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /employments/1
  # DELETE /employments/1.json
  def destroy
    @employment.destroy
    respond_to do |format|
      format.html { redirect_to user_profile_path(@user), notice: 'Employment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_employment
      @employment = Employment.find(params[:id])
    end

    def set_user
      @user = User.find(params[:user_id])
    end

    def set_user_employment
      @employment = current_user.employments.find_by_id(params[:id])

      if @employment == nil
        redirect_to user_profile_path(@user), flash: { alert: "You do not own this listing" }
      end
    end

    # Only allow a list of trusted parameters through.
    def employment_params
      params.require(:employment).permit(:company, :position, :start_date, :end_date)
    end
end
