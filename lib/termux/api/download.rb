require 'open3'

require 'termux/api/base'

module Termux
  module API
    class Download < Termux::API::Base
      def self.run(description: nil, title: nil, url:)
        command = ['termux-download']
        command << "-d #{description}" if description
        command << "-t #{title}" if title
        command << url

        Open3.capture2(*command).first
      end
    end
  end
end

