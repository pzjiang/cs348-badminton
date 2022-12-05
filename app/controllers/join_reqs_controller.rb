class JoinReqsController < ApplicationController


    def new

    end


    def create
        @join_req = JoinReq.create(join_req_params)
        if @join_req.save
            redirect_to @join_req
        else
            render :new, status: :unprocessable_entity
    end

    def show
        @join_req = JoinReq.find(params[:id])
    end


    private
    def join_req_params
        params.require(:join_req).permit(:req_name, :req_role, :team_id, :status)
    end
end
