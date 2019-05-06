class SessionsController < ApplicationController
  skip_before_action :require_sign_in!, only: [:new,:create]
  before_action :set_store, only: [:create]

  def new
  end

  def create
    if @store.authenticate(session_params[:password])
      sign_in(@store)
      redirect_to stores_path
    else
      flash.now[:danger] = t('.flash.invalid_password')
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to login_path
  end

  private

  def set_store
    @store = Store.find_by!(control_number: session_params[:control_number])
  rescue
    flash.now[:danger] = t('.flash.invalid_name')
    render 'new'
  end

  def session_params
    params.require(:session).permit(:control_number, :password)
  end


end
