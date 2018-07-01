require 'json'
require 'open3'

require 'termux/api/base'

module Termux
  module API
    class BatteryStatus < Termux::API::Base
      def self.run
        output = JSON.parse(Open3.capture2('termux-battery-status').first)
        new(
          health: output['health'],
          percentage: output['percentage'],
          plugged: output['plugged'],
          status: output['status'],
          temperature: output['temperature']
        )
      end

      attr_accessor :health, :percentage, :plugged, :status, :temperature
      def initialize(health:, percentage:, plugged:, status:, temperature:)
        @health = health
        @percentage = percentage
        @plugged = plugged
        @status = status
        @temperature = temperature
      end
    end
  end
end
