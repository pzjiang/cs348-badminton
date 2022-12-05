class UsersController < ApplicationController
    def index
        @users = User.all
    end
    def show
        @user = current_user
        @team = Team.find(current_user.team_id)
        @join_reqs = JoinReq.where(user_id: current_user.id)
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

        if params[:paptch][:status] == "Reject"
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