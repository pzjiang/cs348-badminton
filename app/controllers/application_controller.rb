class ApplicationController < ActionController::Base
    # before_action :require_login
    # add to login:
    # skip_before_filter :require_login
    private

    def require_login
      unless current_user
        #redirect to login page
        redirect_to "/users/sign_in"
      end
    end
    def require_logout
      if current_user
        redirect_to "/"
      end
    end


end
