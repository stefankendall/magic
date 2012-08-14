class GameController < ApplicationController
  respond_to :json

  def show
    respond_with Game.find(params[:id])
  end

  def create
    respond_with Game.new_game
  end
end
