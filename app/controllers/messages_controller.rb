class MessagesController < ApplicationController
    # Display all messages
    def index
        # The universal index of messages is only for referees and admins
        if current_user.role == 'Referee' || current_user.role == 'System Admin'
            @messages = Message.all
        # Everyone else is sent to root
        else
            redirect_to root_path
        end
    end

    # Enter data for a new message
    def new
        # Create a new instance of a message
        @message = Message.new
    end

    # Create a new message (from messages#new)
    def create
        @message = Message.new(message_params)
        @message.user_id = current_user.id
        
        # Global messages use team id 0. Players and team admins can only post to global or to their own channel; referees and sysadmins can post anywhere
        if (@message.team_id != 0 && (current_user.role == 'Player' || current_user.role == 'Team Admin'))
            @message.team_id = current_user.team_id
        end
        
        # There are no role restrictions on sending messages in general
        if @message.save
            # On successful save operation, redirect to the new message's page
            redirect_to @message
        else
            # On a failure, redirect to new
            render :new, status: :unprocessable_entity
        end
    end

    # Messages can be edited by non-players
    def edit
        if current_user.role != 'Player'
            @message = Message.find(params[:id])
        else
            redirect_to :index
        end
    end

    # Update an existing message (from messages#edit)
    def update
        @message = Message.find(params[:id])

        if (current_user.role != 'Player' && current_user.id == @message.user_id) && @message.save
            # On successful update operation, redirect to the message's own page
            redirect_to @message
        else
            # On a failure, redirect to edit
            render :edit, status: :unprocessable_entity
        end
    end

    # Display a message if the user has the correct permissions
    def show
        @message = Message.find(params[:id])
        # Admins, referees, and members of the correct team can access messages. Global messages are accessible to anyone.
        if (current_user.role == 'System Admin' || current_user.role == 'Referee' || current_user.team_id == @message.team_id || @message.team_id == 0)
            @message = Message.find(params[:id])
        # If the user has the wrong permissions
        else
            redirect_to root_path
        end
    end

    # Delete an existing message (for a DELETE request). Actually just flags messages.
    def destroy
        @message = Message.find(params[:id])

        if current_user.role == 'Referee' || current_user.role == 'System Admin'
            @message.status = 'Deleted by Admin'
        elsif current_user.id == @message.user_id
            @message.status = 'Deleted'
        end

        # Redirect to root
        redirect_to root_path
    end

    # Enforce integrity of message input data
    private
        def message_params
            params.require(:message).permit(:user_id, :team_id, :body, :status)
        end
end
