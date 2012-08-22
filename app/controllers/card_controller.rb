class CardController < ApplicationController
  def play
    game = Game.find params[:id]
    card = Card.find params[:card_id]
    if params[:ability].present?
      game.activate_ability card, params[:ability]
    else
      game.play_card card
    end

    respond_with game
  end
end
