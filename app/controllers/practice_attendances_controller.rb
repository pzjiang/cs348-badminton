class Practice_attendanceAttendancesController < ApplicationController
    # Create a new practice_attendance (from practice_attendances#new)
    def create
        @practice = Practice.find(params[:practice_id])
        @practice_attendance = @practice.practice_attendances.create(practice_attendance_params)

        if (Current_user.role == 'Team Admin' && Current_user.team_id == @practice.team_id) && @practice_attendance.save
            # On successful save operation, redirect to the practice page
            redirect_to @practice
        else
            # On a failure, redirect to new
            render :new, status: :unprocessable_entity
        end
    end

    # Edit, Update, and Show functionality is way too advanced for this stuff

    # Delete an existing practice_attendance (for a DELETE request)
    def destroy
        @practice = Practice.find(params[:practice_id])
        @practice_attendance = @practice.practice_attendances.find(params[:id])
        
        if ((Current_user.team_id == @practice.team_id && Current_user.role == 'Team Admin'))
            @practice_attendance.destroy
        end

        # Redirect to the practice_attendances index
        redirect_to root_path
    end

    # Enforce integrity of practice_attendance input data
    private
        def practice_attendance_params
            params.require(:practice_attendance).permit(:practice_id, :user_id)
        end
end
