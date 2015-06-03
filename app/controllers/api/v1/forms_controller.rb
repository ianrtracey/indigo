class Api::V1::FormsController < ApplicationController
	before_action :authenticate_with_token!, only: [:create]
	respond_to :json

	def index
	  respond_with Form.all
	end
	
	def show
	 respond_with Form.find(params[:id])
	end

	def create
	  form = current_user.forms.build(form_params)
	  if form.save
	  	render json: form, status: 201, location: [:api, form]
	  else
	    render json: { errors: form.errors }, status: 422
	  end
	end

	def update
	  form = current_user.form.find(params[:id])
	  if form.update(form_params)
	    render json: form, status: 200, location: [:api, form]
	  else
	  	render json: { errors: form.errors }, status: 422
	  end
	end

	private

	  def form_params
	    params.require(:form).permit(:name, :body, :submitted)
	  end
end
