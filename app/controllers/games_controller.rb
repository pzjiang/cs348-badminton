class GamesController < ApplicationController
    # Display all games
    def index
        @gamesRaw = Game.all
        @games = []
        for game in @gamesRaw do
            awayTeam = Team.find(game.loser_id)
            homeTeam = Team.find(game.winner_id)
            @games.push([game, homeTeam, awayTeam])
        end
    end

    # Enter data for a new game
    def new
        

        if current_user.role == 'Referee' || current_user.role == 'System Admin'
            # Create a new instance of a game
            @teams = Team.all
            @teamOptions = []
            for team in @teams do
                puts team.name
                puts team.id
                @teamOptions.push([team.name, team.id])
            end
            @game = Game.new
        else
            redirect_to :index
        end
    end

    # Create a new game (from games#new)
    def create
        @game = Game.new(game_params)
        @game.winner_id = params[:winner_id]
        @game.loser_id = params[:loser_id]

        if (current_user.role == 'Referee' || current_user.role == 'System Admin') && @game.save!
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
        @team = Team.find(current_user.team_id)
        @homeTeam = Team.find(@game.winner_id)
        @homeTeamMembersRaw = User.where(team_id: @homeTeam.id).all
        @homeTeamMembers = []
        for teamMember in @homeTeamMembersRaw do
            attendance = GameAttendance.find_by(user_id: teamMember.id, game_id: @game.id)
            if attendance.present?
                @homeTeamMembers.push(teamMember)
            end
        end
        @awayTeam = Team.find(@game.loser_id)
        @awayTeamMembersRaw = User.where(team_id: @awayTeam.id).all
        @awayTeamMembers = []
        for teamMember in @awayTeamMembersRaw do
            attendance = GameAttendance.find_by(user_id: teamMember.id, game_id: @game.id)
            if attendance.present?
                @awayTeamMembers.push(teamMember)
            end
        end
        @attended = GameAttendance.find_by(user_id: current_user.id, game_id: @game.id).present?
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
            params.require(:game).permit( :winner_score, :loser_score, :date, :location)
        end
end
