class JoinReqsController < ApplicationController


    def new

    end


    def create

        @user = User.find(params[:join_req][:user_id])
        @join_req = JoinReq.new
        @join_req.user_id = params[:join_req][:user_id]
        @join_req.req_name = params[:join_req][:req_name]
        @join_req.req_role = params[:join_req][:req_role]
        @join_req.team_id = params[:join_req][:team_id]
        @join_req.status = params[:join_req][:status]
        
        if @join_req.save
            redirect_to @user
        else
            render :new, status: :unprocessable_entity
        end
    end


    private
    def join_req_params
        params.require(:join_req).permit(:user_id, :req_name, :req_role, :team_id, :status)
    end
end
