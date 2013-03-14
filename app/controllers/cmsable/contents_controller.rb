module Cmsable
  class ContentsController < ApplicationController
    def update
      model = params[:model].constantize

      render :text => false and return if cannot? :update, model

      attribute = model.cmsable_body
      render :text => model.find(params[:id]).update_attribute(attribute, params[:content][:body])
    end
  end
end
