class CardController < ApplicationController
  def play
    game = Game.find params[:id]
    card = Card.find params[:card_id]
    ability = params[:ability].present? ? params[:ability] : 'play'

    game.play_card card, ability

    respond_with game
  end
end
