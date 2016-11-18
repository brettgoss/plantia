class DashboardController < ApplicationController
  def index
    render component: 'Dashboard'
  end
end
