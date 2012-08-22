class StackController < ApplicationController
  def resolve
    game = Game.find params[:id]
    game.resolve_top_of_stack

    respond_with to_json_hash_without_dates(game), :location => nil
  end
end
