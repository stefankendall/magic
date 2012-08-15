class GameController < ApplicationController
  respond_to :json

  def show
    respond_with to_json_hash_without_dates(Game.find(params[:id])), :location => nil
  end

  def create
    respond_with to_json_hash_without_dates(Game.new_game), :location => nil
  end
end
