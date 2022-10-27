class ChallengesController < ApplicationController
    # Display all challenges
    def index
        @challenges = Challenge.all
    end

    # Enter data for a new challenge
    def new
        if current_user.role == 'Team Admin'
            # Create a new instance of a challenge
            @challenge = Challenge.new
        else
            redirect_to :index
        end
    end

    # Create a new challenge (from challenges#new). Only available to team admins.
    def create
        @challenge = Challenge.new(challenge_params)
        @challenge.challenger_id = current_user.team_id # Populate challenger_id

        if current_user.role == 'Team Admin' && @challenge.save
            # On successful save operation, redirect to the new challenge's page
            redirect_to @challenge
        else
            # On a failure, redirect to new
            render :new, status: :unprocessable_entity
        end
    end

    # Edit an existing challenge
    def edit
        # Only these users can modify challenges
        if (current_user.role == 'Team Admin' && current_user.team_id == challenger_id) || current_user.role == 'System Admin'
            @challenge = Challenge.find(params[:id])
        else
            redirect_to :index
        end
    end
    
    # Update an existing challenge (from challenges#edit)
    def update
        @challenge = Challenge.find(params[:id])
        if current_user.role == 'Team Admin'
            @challenge.challenger_id = current_user.team_id
        end

        if (current_user.role == 'Team Admin' || current_user.role == 'System Admin') && @challenge.save
            # On successful update operation, redirect to the challenge's page
            redirect_to @challenge
        else
            # On a failure, redirect to edit
            render :edit, status: :unprocessable_entity
        end
    end

    # Display a challenge
    def show
        @challenge = Challenge.find(params[:id])
    end

    # Delete an existing challenge (for a DELETE request) or withdraw/reject a challenge
    def destroy
        @challenge = Challenge.find(params[:id])
        # System admins can fully delete challenges
        if current_user.role == 'System Admin'
            @challenge.destroy
        # Team admins can reject or withdraw a challenge
        elsif current_user.role == 'Team Admin'
            if current_user.team_id == challenger_id
                @challenge.status = 'Withdrawn'
            elsif current_user.team_id == receiver_id
                @challenge.status = 'Rejected'
            else
                redirect_to :index
            end
            @challenge.save
            redirect_to @challenge
        end

        # Redirect to the challenges index
        redirect_to :index
    end

    # Enforce integrity of challenge input data
    private
        def challenge_params
            params.require(:challenge).permit(:challenger_id, :receiver_id, :status, :game_id, :date_issued, :game_date)
        end
end
