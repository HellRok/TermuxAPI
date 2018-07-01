require 'open3'

require 'termux/api/base'

module Termux
  module API
    class Toast < Termux::API::Base
      def self.run(
        content:,
        background_colour: nil,
        text_colour: nil,
        position: nil,
        short: false
      )

        command = ['termux-toast']
        command << '-s' if short
        command << ['-b', background_colour] if background_colour
        command << ['-c', text_colour] if text_colour
        command << ['-g', position] if position
        command << content
        command.flatten!

        Open3.capture2(*command)
      end
    end
  end
end
