require_dependency "cmsable/application_controller"

module Cmsable
  class ContentsController < ApplicationController
    def update
      render :text => Content.find(params[:id]).update_attribute(:body, params[:content][:body])
    end
  end
end
