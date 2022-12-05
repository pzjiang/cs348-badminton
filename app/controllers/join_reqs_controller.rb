class JoinReqsController < ApplicationController


    def new

    end


    def create
        @join_req = JoinReq.create(join_req_params)
        @user = User.find(current_user.id)
        if @join_req.save
            redirect_to @user
        else
            render :new, status: :unprocessable_entity
        end
    end


    private
    def join_req_params
        params.require(:join_req).permit(:req_name, :req_role, :team_id, :status)
    end
end
