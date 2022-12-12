class GameAttendancesController < ApplicationController
    # Create a new game_attendance (from game_attendances#new)
    def create
        @game = Game.find(params[:game_id])
        @game_attendance = GameAttendance.new
        @game_attendance.user_id = params[:user_id]
        @game_attendance.game_id = params[:game_id]
        @inTeam = @game.winner_id == current_user.team_id || @game.loser_id == current_user.team_id
        
        if  @inTeam && @game_attendance.save
            # On successful save operation, redirect to the game page
            redirect_to @game
        else
            # On a failure, redirect to new
            render :new, status: :unprocessable_entity
        end
    end

    # Edit, Update, and Show functionality is way too advanced for this stuff

    # Delete an existing game_attendance (for a DELETE request)
    def destroy
        @game = Game.find(params[:game_id])
        @game_attendance = @game.game_attendances.find(params[:id])
        
        if ((current_user.team_id == @game.team_id && current_user.role == 'Team Admin'))
            @game_attendance.destroy
        end

        # Redirect to the game_attendances index
        redirect_to root_path
    end

    # Enforce integrity of game_attendance input data
    private
        def game_attendance_params
            params.require(:game_attendance).permit(:game_id, :user_id)
        end
end
