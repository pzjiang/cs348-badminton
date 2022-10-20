class ChallengesController < ApplicationController
    # Display all challenges
    def index
        @challenges = Challenge.all
    end

    # Enter data for a new challenge
    def new
        # Create a new instance of a challenge
        @challenge = Challenge.new
    end

    # Create a new challenge (from challenges#new)
    def create
        @challenge = Challenge.new(challenge_params)

        if @article.save
            # On successful save operation, redirect to the new challenge's page
            redirect_to @challenge
        else
            # On a failure, redirect to new
            render :new, status: :unprocessable_entity
        end
    end

    # Edit an existing challenge
    def edit
        @challenge = Challenge.find(params[:id])
    end
    
    # Update an existing challenge (from challenges#edit)
    def update
        @challenge = Challenge.find(params[:id])

        if @article.save
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

    # Delete an existing challenge (for a DELETE request)
    def destroy
        @challenge = Challenge.find(params[:id])
        @challenge.destroy

        # Redirect to the challenges index
        redirect_to :index
    end

    # Enforce integrity of challenge input data
    private
        def challenge_params
            params.require(:challenge).permit(:challenger_id, :receiver_id, :status, :game_id, :date_issued, :game_date)
        end
end
