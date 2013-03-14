require_dependency "cmsable/application_controller"

module Cmsable
  class ContentsController < ApplicationController
    def update
      model = params[:model].constantize
      attribute = model.cmsable_body
      render :text => model.find(params[:id]).update_attribute(attribute, params[:content][:body])
    end
  end
end
