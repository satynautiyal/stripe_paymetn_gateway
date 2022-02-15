class ApplicationController < ActionController::Base
    def authenticate_admin
        unless user_signed_in? && current_user.role == "admin"
            redirect_to root_url, notice: "You are not authorize for this action"   
        end
    end
end
