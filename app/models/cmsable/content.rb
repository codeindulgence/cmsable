module Cmsable
  class Content < ActiveRecord::Base
    # Extensions
    cmsable

    # Attribute accessibility
    attr_accessible :body, :name

    # Validations
    validates :name, :presence => true

    # Virtual Attributes

    # Callbacks

    # Instance Methods

    # Class Methods
    def self.set name, body
      find_by_name(name).update_attribute :body, body
    end

    def self.get name
      find_or_create_by_name name, :body => "Awaiting Content"
    end

    # Scopes
  end
end
