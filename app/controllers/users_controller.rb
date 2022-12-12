class UsersController < ApplicationController
    def index
        @users = User.all
    end
    def show
        
        @team = Team.find(current_user.team_id)
        @join_reqs = JoinReq.where(user_id: current_user.id).all
        @practice_attendances = PracticeAttendance.where(user_id: current_user.id).all
        @practices = []
        for attendance in @practice_attendances do
            tempPractice = Practice.find(attendance.practice_id)
            @practices.push(tempPractice)
          end
        @game_attendances = GameAttendance.where(user_id: current_user.id).all
        @games = []
        for gAttendance in @game_attendances do
            tempGame = Game.find(gAttendance.game_id)
            awayTeam = Team.find(tempGame.loser_id)
            homeTeam = Team.find(tempGame.winner_id)
            @games.push([tempGame, homeTeam, awayTeam])
        end
        
    end

    def change_role
        @user = User.find(current_user.id)
        # puts "printing intput"

        # puts params[:patch][:role]
        if @user.update(role: params[:patch][:role])
            respond_to do |format|
            format.html { redirect_to @user, notice: "User role changed" }
            format.json { render :show, status: :ok, location: @user }
            end
        else
            respond_to do |format|
            format.html { render :show, status: :unprocessable_entity }
            format.json { render json: @user.errors, status: :unprocessable_entity }
            end
            puts @user.errors.full_messages.to_sentence
        end

    end

    def join_accept
        @join_req = JoinReq.find(params[:patch][:id])
        @user = User.find(params[:patch][:user_id])
        @team = Team.find(params[:patch][:team_id])

        if params[:patch][:status] == "Reject"
            @join_req.status = "Deleted"
            @join_req.save
            redirect_to @team            
        end


        @user.team_id = @team.id
        @user.role = "Player"
        if @user.save
            @join_req.status = "Accepted"
            @join_req.save
            redirect_to @team
        end
    end
end