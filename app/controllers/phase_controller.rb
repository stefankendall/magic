class PhaseController < ApplicationController
  def next
    game_id = params[:id]
    game = Game.find(game_id)
    game.turn.next_phase

    respond_with to_json_hash_without_dates(game), :location => nil
  end
end
