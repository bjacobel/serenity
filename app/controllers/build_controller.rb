class BuildController < ApplicationController
  def index
    @builds = Build.all
  end
end
