class ApplicationController < ActionController::Base
    def not_found_method
        render 'wip/index', status: :not_found
      end
end
