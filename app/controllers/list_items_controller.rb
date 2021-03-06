class ListItemsController < ApplicationController
  protect_from_forgery with: :exception
  before_action :set_list_item, only: [:show, :edit, :update, :destroy]

  # GET /list_items
  # GET /list_items.json
  def index
    @list_type = (ListType.find_by id: params[:list_type_id]) || ListType.first
    if current_user
      @list_items = current_user.items_from_list @list_type.id
    else
      redirect_to '/sessions/new'
    end

  end

  # GET /list_items/1
  # GET /list_items/1.json
  def show
  end

  # GET /list_items/new
  def new
    @list_item = ListItem.new list_item_params
  end

  # GET /list_items/1/edit
  def edit
  end

  # POST /list_items
  # POST /list_items.json
  def create
    @list_item = ListItem.create list_item_params
    respond_to do |format|
      if @list_item.errors.any?
        format.html { render :new }
        format.json { render json: @list_item.errors, status: :unprocessable_entity }
      else
        # format.html { redirect_to @list_item, notice: 'List item was successfully created.' }
        format.html { redirect_to list_items_path(list_type_id: @list_item.list_type_id), notice: "'#{@list_item.title.truncate 50}' now listed." }
        format.json { render :show, status: :created, location: @list_item }
      end
    end
  end

  # PATCH/PUT /list_items/1
  # PATCH/PUT /list_items/1.json
  def update
    respond_to do |format|
      if @list_item.update list_item_params
        format.html { redirect_to list_items_url(list_type_id: @list_item.list_type_id), notice: "'#{@list_item.title.truncate(50)}' was successfully updated." }
        format.json { render json: @list_item, status: :ok }
      else
        format.html { render :edit }
        format.json { render json: @list_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /list_items/1
  # DELETE /list_items/1.json
  def destroy
    @list_item.destroy
    respond_to do |format|
      format.html { redirect_to list_items_url(list_type_id: @list_item.list_type_id), notice: "'#{@list_item.title.truncate(50)}' is gone for good." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_list_item
      @list_item = ListItem.find params[:id]
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def list_item_params
      params.
          require(:list_item).
          permit :user_id, :list_type_id, :title, :description, :link
    end
end
