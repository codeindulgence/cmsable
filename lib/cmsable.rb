require "cmsable/engine"

module Cmsable

  mattr_accessor :authorised

  module ClassMethods
    def cmsable options = {}

      cattr_accessor :cmsable_body

      options = {
        :body => :body
      }.merge options

      self.cmsable_body = options[:body]

    end
  end

end

# Add cmsable method to ActiveRecord classes
ActiveRecord::Base.send :extend, Cmsable::ClassMethods
