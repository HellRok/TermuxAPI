require 'open3'

require 'termux/api/base'

module Termux
  module API
    class Vibrate < Termux::API::Base
      def self.run(duration: 1000, force: false)
        command = ['termux-vibrate']
        command << "-d #{duration}" if duration
        command << "-f" if force

        Open3.capture2(*command)
      end
    end
  end
end


