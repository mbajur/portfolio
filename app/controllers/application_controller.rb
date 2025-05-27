class ApplicationController < ActionController::Base
  include Pagy::Backend

  helper_method :pagy_countless
end
