module Api
  module V1
    class ListItemsController < ApplicationController
      before_action :set_list_item, only: [:show, :edit, :update, :destroy]
      before_action :doorkeeper_authorize!
      respond_to :json

      def index
        respond_with ListItem.where(user_id: doorkeeper_token.resource_owner_id)
      end

      def show
        respond_with ListItem.find(params[:id])
      end

      # POST /list_items
      # POST /list_items.json
      def create
        respond_with ListItem.create(list_item_params(user_id: doorkeeper_token.resource_owner_id))
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

    end
  end
end
