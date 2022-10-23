class PracticesController < ApplicationController
    # Display all practices. Only visible for admins and referees.
    def index
        if Current_user.role == 'System Admin' || Current_user.role == 'Referee'
            @practices = Practice.all
        else
            redirect_to root_path
        end
    end

    # Enter data for a new practice
    def new
        if Current_user.role == 'Team Admin'
            # Create a new instance of a practice
            @practice = Practice.new
        else
            redirect_to :index
        end
    end

    # Create a new practice (from practices#new)
    def create
        @teamid = Current_user.team_id
        @practice = @team.practices.create(practice_params)
        @practice.team_id = @teamid

        if (Current_user.role == 'Team Admin') && @practice.save
            # On successful save operation, redirect to the new practice's page
            redirect_to @practice
        else
            # On a failure, redirect to new
            render :new, status: :unprocessable_entity
        end
    end

    # Edit an existing practice
    def edit
        @practice = Practice.find(params[:id])
        unless (Current_user.role == 'Team Admin') && (Current_user.team_id == @practice.team_id)
            redirect_to :index
        end
    end
    
    # Update an existing practice (from practices#edit)
    def update
        @practice = Practice.find(params[:id])

        if (Current_user.role == 'Team Admin' && Current_user.team_id == @practice.team_id) && @practice.save
            # On successful update operation, redirect to the practice's page
            redirect_to @practice
        else
            # On a failure, redirect to edit
            render :edit, status: :unprocessable_entity
        end
    end

    # Display a practice to team members or to referees/sysadmins only
    def show
        @practice = Practice.find(params[:id])
        unless ((Current_user.team_id == @practice.team_id) || (Current_user.role == 'Referee' || Current_user.role == 'System Admin'))
            redirect_to root_path
        end
    end

    # Delete an existing practice (for a DELETE request)
    def destroy
        @practice = Practice.find(params[:id])
        if ((Current_user.team_id == @practice.team_id && Current_user.role == 'Team Admin') || (Current_user.role == 'System Admin'))
            @practice.destroy
        end

        # Redirect to the practices index
        redirect_to root_path
    end

    # Enforce integrity of practice input data
    private
        def practice_params
            params.require(:practice).permit(:team_id, :date, :location)
        end
end