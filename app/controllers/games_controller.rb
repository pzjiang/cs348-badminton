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
        @article = Article.new(article_params)

        if @article.save
            # On successful save operation, redirect to the new game's page
            redirect_to @game
        else
            render :new, status: :unprocessable_entity
        end
    end
    
    # Edit an existing game
    def update
    end

    # Display a game
    def show
    end

    # Delete an existing game
    def destroy
    end

    # Enforce integrity of game input data
    def game_params
        params.require(:game).permit(:winner_id, :loser_id, :winner_score, :loser_score, :date, :location)
    end
end
