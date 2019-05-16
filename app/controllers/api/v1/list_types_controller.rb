
module Api
  module V1
    class ListTypesController < ApplicationController
      before_action :set_list_type, only: [:show, :edit, :update, :destroy]
      before_action :doorkeeper_authorize!
      respond_to :json

      # GET /list_types
      # GET /list_types.json
      def index
        respond_with ListType.all
      end

      # GET /list_types/1
      # GET /list_types/1.json
      def show
        respond_with ListType.find(params[:id])
      end

      # GET /list_types/new
      def new
        respond_with ListType.new
      end

      # GET /list_types/1/edit
      def edit
      end

      # POST /list_types
      # POST /list_types.json
      def create
        respond_with ListType.create(list_type_params)
      end

      # PATCH/PUT /list_types/1
      # PATCH/PUT /list_types/1.json
      def update
        respond_with ListType.update(params[:id], list_type_params)
      end

      # DELETE /list_types/1
      # DELETE /list_types/1.json
      def destroy
        respond_with ListType.destroy(params[:id])
      end

      private
      # Use callbacks to share common setup or constraints between actions.
      def set_list_type
        @list_type = ListType.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def list_type_params
        params.require(:list_type).permit(:title, :noun_spec, :verb_spec)
      end
    end
  end
end
