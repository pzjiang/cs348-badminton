class GamesController < ApplicationController
    # Display all games
    def index
        @games = Game.all
    end

    # Enter data for a new game
    def new
        # Create a new instance of a game
        @game = Game.new
    end

    # Create a new game (from games#new)
    def create
        @game = Game.new(game_params)

        if @article.save
            # On successful save operation, redirect to the new game's page
            redirect_to @game
        else
            # On a failure, redirect to new
            render :new, status: :unprocessable_entity
        end
    end

    # Edit an existing game
    def edit
        @game = Game.find(params[:id])
    end
    
    # Update an existing game (from games#edit)
    def update
        @game = Game.find(params[:id])

        if @article.save
            # On successful update operation, redirect to the game's page
            redirect_to @game
        else
            # On a failure, redirect to edit
            render :edit, status: :unprocessable_entity
        end
    end

    # Display a game
    def show
        @game = Game.find(params[:id])
    end

    # Delete an existing game (for a DELETE request)
    def destroy
        @game = Game.find(params[:id])
        @game.destroy

        # Redirect to the games index
        redirect_to :index
    end

    # Enforce integrity of game input data
    private
        def game_params
            params.require(:game).permit(:winner_id, :loser_id, :winner_score, :loser_score, :date, :location)
        end
end
