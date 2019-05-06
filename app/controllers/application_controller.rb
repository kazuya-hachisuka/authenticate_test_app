class ApplicationController < ActionController::Base

  before_action :current_store
  before_action :require_sign_in!
  helper_method :sign_in?

  protect_from_forgery with: :exception

  def current_store
    remember_token = Store.encrypt(cookies[:store_remember_token])
    @current_store ||= Store.find_by(remember_token: remember_token)
  end

  def sign_in(store)
    remember_token = Store.new_remember_token
    cookies.permanent[:store_remember_token] = remember_token
    store.update!(remember_token: Store.encrypt(remember_token))
    @current_store = store
  end

  def sign_out
    cookies.delete(:store_remenber_token)
  end

  def signed_in?
    @current_store.present?
  end

  private

  def require_sign_in!
    redirect_to login_path unless signed_in?
  end
end
