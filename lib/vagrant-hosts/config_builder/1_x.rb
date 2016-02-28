require 'config_builder/model'

# Integration with ConfigBuilder 1.x and newer
module VagrantHosts
  module ConfigBuilder
    class Model < ::ConfigBuilder::Model::Provisioner::Base

      # @!attribute [rw] hosts
      def_model_attribute :hosts
      # @!attribute [rw] autoconfigure
      def_model_attribute :autoconfigure
      # @!attribute [rw] add_localhost_hostnames
      def_model_attribute :add_localhost_hostnames
      # @!attribute [rw] sync_hosts
      def_model_attribute :sync_hosts
      def_model_attribute :exports
      def_model_attribute :imports

      def initialize
        @hosts = []
      end

      # @private
      def configure_hosts(config, val)
        val.each do |(address, aliases)|
          config.add_host(address, aliases)
        end
      end

      ::ConfigBuilder::Model::Provisioner.register('hosts', self)
    end
  end
end
