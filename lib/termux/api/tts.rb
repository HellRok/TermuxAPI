require 'open3'
require 'json'

require 'termux/api/base'

module Termux
  module API
    module TTS
      class Engines < Termux::API::Base
        def self.run
          engines = JSON.parse(Open3.capture2('termux-tts-engines').first)
          engines.map do |engine|
            Termux::API::TTS::Engine.new(
              name: engine['name'],
              label: engine['label'],
              default: engine['default']
            )
          end
        end
      end

      class Engine < Termux::API::Base
        attr_accessor :name, :label, :default
        alias_method :to_s, :name
        def initialize(name:, label:, default:)
          @name = name
          @label = label
          @default = default
        end
      end

      class Speak < Termux::API::Base
        def self.run(
          content:,
          engine: nil,
          language: nil,
          region: nil,
          variant: nil,
          pitch: nil,
          rate: nil,
          stream: nil
        )

          command = ['termux-tts-speak']
          command << ['-e', engine.to_s] if engine
          command << ['-l', language] if language
          command << ['-n', region] if region
          command << ['-v', variant] if variant
          command << ['-p', pitch.to_s] if pitch
          command << ['-r', rate.to_s] if rate
          command << ['-s', stream] if stream
          command << content
          command.flatten!

          Open3.capture2(*command)
        end
      end
    end
  end
end
