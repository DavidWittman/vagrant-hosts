require 'config_builder/model'

module VagrantHosts
  module ConfigBuilder
    class Model < ::ConfigBuilder::Model::Base

      # @!attribute [rw] hosts
      attr_accessor :hosts
      # @!attribute [rw] autoconfigure
      attr_accessor :autoconfigure
      # @!attribute [rw] add_localhost_hostnames
      attr_accessor :add_localhost_hostnames

      def initialize
        @hosts = []
      end

      def to_proc
        Proc.new do |vm_config|
          vm_config.provision :hosts do |h_config|
            h_config.autoconfigure = attr(:autoconfigure) unless attr(:autoconfigure).nil?
            h_config.add_localhost_hostnames = attr(:add_localhost_hostnames) unless attr(:add_localhost_hostnames).nil?

            @hosts.each do |(address, aliases)|
              h_config.add_host address, aliases
            end
          end
        end
      end

      ::ConfigBuilder::Model::Provisioner.register('hosts', self)
    end
  end
end
