class Admin::HomesController < ApplicationController
  layout 'admin_header'
  before_action :authenticate_admin!
  def top
  end
end
