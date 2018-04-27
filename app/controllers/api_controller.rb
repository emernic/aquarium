class ApiController < ApplicationController

  before_action :set_paper_trail_whodunnit

  def main
    render json: Oj.dump((Api.new params).run, mode: :compat)
  end

end

