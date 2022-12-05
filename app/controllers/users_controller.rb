class UsersController < ApplicationController
    def index
        @users = User.all
    end
    def show
        @user = current_user
        @team = Team.find(current_user.team_id)
        @practices = Practice_attendance.where(user_id: @user.user_id)
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
end