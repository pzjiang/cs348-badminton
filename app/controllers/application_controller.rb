class ApplicationController < ActionController::Base
    before_filter :require_login
    # add to login:
    # skip_before_filter :require_login
    private

    def require_login
        unless current_user
            redirect_to login_url
    end
  end

end
