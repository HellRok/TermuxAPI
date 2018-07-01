require 'open3'
require 'json'

require 'termux/api/base'

module Termux
  module API
    class Dialog < Termux::API::Base
      def self.run(
        type: 'text',
        hint: nil,
        title: nil,
        multiline: false,
        password: false,
        number: false,
        minimum: nil,
        maximum: nil,
        start: nil,
        values: []
      )
        raise "You must provide values for type #{type}" if values.empty? && %w(checkbox radio sheet spinner).include?(type.downcase)
        raise "You must provide minimum, maximum, and start" unless
          [minimum, maximum, start].all? { |i| !i } ||
          [minimum, maximum, start].all? { |i| i }

        command = ['termux-dialog']
        command << type
        command << ['-i', hint] if hint
        command << "-m" if multiline
        command << "-n" if number
        command << "-p" if password
        command << ['-v', values.join(',')] if values.any?
        command << ['-r', [minimum, maximum, start].join(',')] if minimum
        command << ['-t', title] if title
        command.flatten!

        output = JSON.parse(Open3.capture2(*command).first)
        new(
          code: output['code'],
          text: output['text']
        )
      end

      attr_accessor :code, :text
      def initialize(code:, text:)
        # Codes and what they mean (I think)
        #   0: Selected from sheet
        #  -1: User clicked ok
        #  -2: User clicked cancel
        @code = code
        @text = text
      end
    end
  end
end
