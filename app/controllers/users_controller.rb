class UsersController < ApplicationController
	before_action :set_user, only: [:destroy]
	respond_to :html

	def index
		@users = User.all
		respond_with(@users)
	end

	def destroy
	  @user.destroy
      respond_with(@user)
	end

	private
    def set_user
      @user = User.find(params[:id])
    end
end