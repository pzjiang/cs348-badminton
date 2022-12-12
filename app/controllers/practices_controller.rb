class PracticesController < ApplicationController
    # Display all practices. Only visible for admins and referees.
    def index
        if current_user.role == 'System Admin' || current_user.role == 'Referee'
            @rawPractices = Practice.all
            @practices = []
            for rawPractice in @rawPractices do
                tempTeam = Team.find(rawPractice.team_id)
                @practices.push([rawPractice, tempTeam.name])
            end
        else
            redirect_to root_path
        end
    end

    #display team practices

    # Enter data for a new practice
    def new
        if current_user.role == 'Team Admin'
            # Create a new instance of a practice
            @practice = Practice.new
        else
            redirect_to team_path(current_user.team_id)
        end
    end

    # Create a new practice (from practices#new)
    def create
        @teamid = current_user.team_id
        @team = Team.find(@teamid)
        @practice = @team.practices.create(practice_params)
        @practice.team_id = @teamid

        if (current_user.role == 'Team Admin' || current_user.role == "System Admin") && @practice.save
            # On successful save operation, redirect to the team page
            redirect_to @team
        else
            # On a failure, redirect to new
            render :new, status: :unprocessable_entity
        end
    end

    # Edit an existing practice
    def edit
        @practice = Practice.find(params[:id])
        unless (current_user.role == 'Team Admin') && (current_user.team_id == @practice.team_id)
            redirect_to :index
        end
    end
    
    # Update an existing practice (from practices#edit)
    def update
        @practice = Practice.find(params[:id])

        if (current_user.role == 'Team Admin' && current_user.team_id == @practice.team_id) && @practice.save
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
        @team = Team.find(@practice.team_id)
        unless ((current_user.team_id == @practice.team_id) || (current_user.role == 'Referee' || current_user.role == 'System Admin'))
            redirect_to root_path
        end
        @attendees = []
        @practice_attendances = PracticeAttendance.where(practice_id: params[:id]).all
        @attended = false
        for attend in @practice_attendances do
            tempUser = User.find(attend.user_id)
            @attendees.push(tempUser)
            if attend.user_id = current_user.id
                @attended = true
            end
        end
        
    end

    # Delete an existing practice (for a DELETE request)
    def destroy
        @practice = Practice.find(params[:id])
        if ((current_user.team_id == @practice.team_id && current_user.role == 'Team Admin') || (current_user.role == 'System Admin'))
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
