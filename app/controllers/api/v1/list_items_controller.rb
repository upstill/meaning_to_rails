module Api
  module V1
    class ListItemsController < ApplicationController
      class ListItem < ::ListItem
        def as_json(options={})
          super.except *%w{ id user_id list_type_id created_at updated_at }
        end
      end
      
      before_action :set_list_item, only: [:show, :edit, :update, :destroy]
      before_action :doorkeeper_authorize!
      respond_to :json

      def index
        respond_with current_user.list_items.where(list_type_id: params[:list_type_id])
      end

      def show
        respond_with ListItem.find(params[:id])
      end

      # POST /list_items
      # POST /list_items.json
      def create
        lip = list_item_params list_type_id: params[:list_type_id]
        new_item = current_user.list_items.create(lip)
        respond_with new_item
      end

      # PATCH/PUT /list_items/1
      # PATCH/PUT /list_items/1.json
      def update
        respond_to do |format|
          if @list_item.update(list_item_params)
            format.html { redirect_to @list_item, notice: 'List item was successfully updated.' }
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
        respond_to do |format|
          if @list_item.destroy
            format.html { redirect_to @list_item, notice: 'List item was successfully destroyed.' }
            format.json { render json: @list_item, status: :ok }
          else
            format.html { render :edit }
            format.json { render json: @list_item.errors, status: :unprocessable_entity }
          end
        end
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_list_item
        @list_item = ListItem.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def list_item_params extras={}
        params.require(:list_item).merge(extras).except(:id).permit(:list_type_id, :user_id, :title, :description, :link, :onHold, :suggested)
      end
      private
      def current_user
        @current_user ||= User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
      end
    end
  end
end
