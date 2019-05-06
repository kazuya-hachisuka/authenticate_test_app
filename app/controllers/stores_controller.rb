class StoresController < ApplicationController
  skip_before_action :require_sign_in!, only: [:new, :create]

  def new
    @store = Store.new
  end

  def create
    @store = Store.new(store_params)
    if @store.save
      redirect_to login_path
    else
      render 'new'
    end
  end

  private
  def store_params
    params.require(:store).permit(:name,:control_number,:password,:password_confirmation)
  end
end
