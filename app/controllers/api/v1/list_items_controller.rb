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
        respond_with current_user.list_items
      end

      def show
        respond_with ListItem.find(params[:id])
      end

      # POST /list_items
      # POST /list_items.json
      def create
        respond_with current_user.list_items.create(list_item_params)
      end

      # PATCH/PUT /list_items/1
      # PATCH/PUT /list_items/1.json
      def update
        respond_with ListItem.update(params[:id], list_item_params)
      end

      # DELETE /list_items/1
      # DELETE /list_items/1.json
      def destroy
        respond_with ListItem.destroy(params[:id])
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_list_item
        @list_item = ListItem.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def list_item_params extras={}
        params.require(:list_item).merge(extras).permit(:list_type_id, :user_id, :title, :description, :link)
      end
      private
      def current_user
        @current_user ||= User.find(doorkeeper_token.resource_owner_id)
      end
    end
  end
end
