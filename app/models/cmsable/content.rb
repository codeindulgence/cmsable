module Cmsable
  class Content < ActiveRecord::Base
    # Extensions
    cmsable

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
      find_or_create_by name: name do |record|
        body = I18n.t("cmsable.#{name}", default: "<p>Awaiting Content</p><script>alert('Cmsable entry \"#{name}\" is awaiting content');</script>")
        record.update body: body
      end
    end

    # Scopes
  end
end
