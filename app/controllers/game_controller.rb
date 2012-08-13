class GameController < ApplicationController
  def show
    render json: '{}'
  end

  def create
    render json: Game.new_game
  end
end
