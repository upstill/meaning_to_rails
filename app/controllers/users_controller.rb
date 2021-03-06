class UsersController < ApplicationController
  protect_from_forgery with: :exception, except: [:new, :create]
  before_action :set_user, only: [:show, :edit, :update, :destroy, :clear_imports ]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    User.create_with_omniauth
    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def clear_imports
    # Clear the imports buffer, optionally accepting all pending
    if params['accept'] == 'true'
      @user.import_contents = nil if @user.imports.present? # Setup for file read into the contents
      @user.imports.each { |li| @user.list_items << li }
    end
    redirect = list_items_path(list_type_id: @user.import_type_id)
    @user.import_type = @user.import_contents = nil
    @user.import.purge_later # Nuke the import
    @user.save
    respond_to do |format|
      format.html { redirect_to redirect, notice: 'Candidate imports were cleared.' }
      format.json {render :show, status: :ok, location: @user}
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html {
          if user_params['import'].present?
            notice = @user.imports.present? ?
                         'File was read. Go to the bottom of the page to finish importing.' :
                         'Nothing could be read from the file. The subject must appear first on a line (no tabs before), and it must be unique.'
            redirect_to list_items_path(list_type_id: @user.import_type_id), notice: notice
          else
            redirect_to @user, notice: 'User was successfully updated.'
          end
        }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html {
          if user_params['import'].present?
            redirect_to list_items_path(list_type_id: @user.import_type_id), notice: "File couldn't be imported. We can only understand text files."
          else
            render :edit
          end
        }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.
          require(:user).
          permit :name, :password, :password_confirmation, :password_digest, :import, :import_type_id, :import_contents
    end
end
