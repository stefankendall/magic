class CardController < ApplicationController
  def play
    game = Game.find params[:id]
    card = Card.find params[:card_id]
    game.play_card card

    respond_with game
  end
end
