# View Helper
require 'app/helpers/cmsable_helper'
ActionView::Base.send :include, CmsableHelper

# Cmsable model ActiveRecord methods
module Cmsable
  def self.included(base)
    base.send :extend, ClassMethods
  end

  module ClassMethods
    def cmsable(options = {})
      # Setup options and defaults
      cattr_accessor :cmsable_options
      self.cmsable_options = {
        :get => :get,
        :set => :set,
        :name => :name,
        :body => :body,
        :validate_name => true,
        :validate_body => true
      }.merge options

      # Main method for creating/getting some content
      self.class.send :define_method, self.cmsable_options[:get] do |name|
        throw "Missing cmsable #{cmsable_options[:name]}" if name.nil?
        send(
          "find_or_create_by_#{cmsable_options[:name]}",
          name, cmsable_options[:body] => "Awaiting Content - look for \"#{name}\" in the content manager"
        )
      end

      # Main method for updating content
      self.class.send :define_method, self.cmsable_options[:set] do |name, body|
        throw "Missing cmsable #{cmsable_options[:name]}" if name.nil?
        throw "Missing cmsable #{cmsable_options[:body]}" if body.nil?
        find_by_name(name).update_attribute cmsable_options[:body], body
      end

      # Instance to string returns body
      define_method :to_s do
        self.send self.cmsable_options[:body]
      end

      validates_uniqueness_of cmsable_options[:name]
      validates_presence_of cmsable_options[:name] if cmsable_options[:validate_name]
      validates_presence_of cmsable_options[:body] if cmsable_options[:validate_body]
    end
  end
end

ActiveRecord::Base.send :include, Cmsable
