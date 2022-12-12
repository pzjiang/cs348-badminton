class TeamsController < ApplicationController
    # Display all teams
    def index
        @teamsRaw = Team.all
        @teams = []
        for teamRaw in @teamsRaw do
            tempUsers = User.where(team_id: teamRaw.id).all
            @teams.push([teamRaw, tempUsers.length()])
        end
    end

    # Enter data for a new team
    def new
        if current_user.role == 'System Admin'
            # Create a new instance of a team
            @team = Team.new
        else
            redirect_to :index
        end
    end

    # Create a new team (from teams#new)
    def create
        @team = Team.new(team_params)

        if (current_user.role == 'System Admin') && @team.save
            # On successful save operation, redirect to the new team's page
            redirect_to @team
        else
            # On a failure, redirect to new
            render :new, status: :unprocessable_entity
        end
    end

    # Edit an existing team
    def edit
        if current_user.role == 'System Admin' || (current_user.role == 'Team Admin' && params[:id] == current_user.team_id)
            @team = Team.find(params[:id])
        else
            redirect_to :index
        end
    end
    
    # Update an existing team (from teams#edit)
    def update
        @team = Team.find(params[:id])
        
        # System Admins and appropriate Team Admins can edit a team
        if (current_user.role == 'System Admin' || (current_user.role == 'Team Admin' && params[:id] == current_user.team_id)) && @team.save
            # On successful update operation, redirect to the team's page
            redirect_to @team
        else
            # On a failure, redirect to edit
            render :edit, status: :unprocessable_entity
        end
    end

    # Display a team
    def show
        @team = Team.find(params[:id])
        @members = User.where(team_id: params[:id]).all
        @messages = Message.where(team_id: params[:id]).where(status: 'Sent')
        @rawPractices = @team.practices
        @practices = []
        for practice in @rawPractices do
            tempAttend = PracticeAttendance.find_by(user_id: current_user.id, practice_id: practice.id)
            if tempAttend.present?
                @practices.push([practice, false])
            else
                @practices.push([practice, true])
            end
        end
        @join_req = JoinReq.new
        @join_reqs = JoinReq.where(team_id: @team.id).all
        @practice = Practice.new

        @awayGames = []
        @homeGames = []
        @awayRaw = Game.where(loser_id: params[:id])
        @homeRaw = Game.where(winner_id: params[:id])
        @victories = 0
        @defeats = 0
        for awayR in @awayRaw do
            tempTeam = Team.find(awayR.winner_id)
            gameattend = GameAttendance.find_by(game_id: awayR.id, user_id: current_user.id)
            @awayGames.push([awayR, tempTeam, gameattend.present?])
            if awayR.loser_score > awayR.winner_score
                @victories += 1
            else
                @defeats += 1
            end
        end
        for homeR in @homeRaw do
            tempTeam = Team.find(homeR.loser_id)
            @homeGames.push([homeR, tempTeam])
            if homeR.winner_score > homeR.loser_score
                @victories += 1
            else
                @defeats += 1
            end
        end
    end

    # Destroying a team would completely screw with game records and users. If an admin wants to destroy a team, just kick all of its members.
=begin
    # Delete an existing team (for a DELETE request)
    def destroy
        if current_user.role == 'System Admin'
            @team = Team.find(params[:id])
            @team.destroy
            # TODO: Handle users on this team
        end

        # Redirect to the teams index
        redirect_to :index
    end
=end

    # Enforce integrity of team input data
    private
        def team_params
            params.require(:team).permit(:name, :location)
        end
end
