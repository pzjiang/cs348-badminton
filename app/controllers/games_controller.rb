class GamesController < ApplicationController
    # Display all games
    def index
        @games = Game.all
    end

    # Enter data for a new game
    def new
        if current_user.role == 'Referee' || current_user.role == 'System Admin'
            # Create a new instance of a game
            @game = Game.new
        else
            redirect_to :index
        end
    end

    # Create a new game (from games#new)
    def create
        @game = Game.new(game_params)

        if (current_user.role == 'Referee' || current_user.role == 'System Admin') && @game.save
            # On successful save operation, redirect to the new game's page
            redirect_to @game
        else
            # On a failure, redirect to new
            render :new, status: :unprocessable_entity
        end
    end

    # Edit an existing game
    def edit
        if current_user.role == 'Referee' || current_user.role == 'System Admin'
            @game = Game.find(params[:id])
        else
            redirect_to :index
        end
    end
    
    # Update an existing game (from games#edit)
    def update
        @game = Game.find(params[:id])

        if (current_user.role == 'Referee' || current_user.role == 'System Admin') && @game.save
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
        if current_user.role == 'Referee' || current_user.role == 'System Admin'
            @game = Game.find(params[:id])
            if @game.destroy
                respond_to do |format|
                    format.html { redirect_to games_url, notice: "Game was successfully destroyed." }
                    format.json { head :no_content }
                end
            end
        end

        # Redirect to the games index
        
    end

    # Enforce integrity of game input data
    private
        def game_params
            params.require(:game).permit(:winner_id, :loser_id, :winner_score, :loser_score, :date, :location)
        end
end
