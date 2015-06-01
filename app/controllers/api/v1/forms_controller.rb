class Api::V1::FormsController < ApplicationController
	respond_to :json

	def index
	  respond_with Form.all
	end

	
	def show
	 respond_with Form.find(params[:id])
	end
end
