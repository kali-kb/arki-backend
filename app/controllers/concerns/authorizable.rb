module Authorizable
    extend ActiveSupport::Concern

    included do
        before_action :authorize_request
    end

    
end