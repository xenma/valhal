# -*- encoding : utf-8 -*-
module Concerns
  # Handles the administrative metadata.
  module AdminMetadata
    extend ActiveSupport::Concern

    included do
      has_metadata :name => 'adminMetadata', :type => Datastreams::AdminDatastream
      has_metadata :name => 'permissionMetadata', :type=> Datastreams::PermissionMetadata

      has_attributes :activity, :workflow_status, :embargo, :embargo_date, :embargo_condition, :access_condition,
                     :copyright, :material_type, :availability, :collection,
                     datastream: 'adminMetadata', :multiple => false

      def permissions=(val)
        logger.debug("setting permissions #{val}")
        val['instance']['group'].each do |access,groups|
          groups.each{|g| permissionMetadata.add_instance_permission(g,access,'group')} unless groups.blank?
        end
        val['file']['group'].each do |access,groups|
          groups.each{|g| permissionMetadata.add_file_permission(g,access,'group')} unless groups.blank?
        end
      end

      def permissions
        permissions = {}
        permissions['file'] = {}
        permissions['file']['group'] = {}
        Administration::ControlledList.with(:name, 'Hydra Access Types').elements.each do |elem|
          permissions['file']['group'][elem.name] = permissionMetadata.get_file_groups(elem.name,'group')
        end
        permissions['instance'] = {}
        permissions['instance']['group'] = {}
        Administration::ControlledList.with(:name, 'Hydra Access Types').elements.each do |elem|
          permissions['instance']['group'][elem.name] = permissionMetadata.get_file_groups(elem.name,'group')
        end
        permissions
      end
    end
  end
end
