# encoding: utf-8
require 'cmsable/engine'

module Cmsable
  mattr_accessor :authorised

  # Add cmsable method to ActiveRecord classes
  module ClassMethods
    def cmsable(options = {})
      cattr_accessor :cmsable_body

      options = {
        body: :body
      }.merge options

      self.cmsable_body = options[:body]
    end
  end
end

ActiveRecord::Base.send :extend, Cmsable::ClassMethods
