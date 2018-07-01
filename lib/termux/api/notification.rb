require 'open3'

require 'termux/api/base'

module Termux
  module API
    class Notification < Termux::API::Base
      def self.run(
        content:,
        title: nil,
        id: nil,
        sound: false,
        priority: nil,
        vibrate: nil,
        led_colour: nil,
        led_on: nil,
        led_off: nil,
        action: nil,
        on_delete_action: nil,
        button_1: nil,
        button_1_action: nil,
        button_2: nil,
        button_2_action: nil,
        button_3: nil,
        button_3_action: nil
      )

        command = ['termux-notification']
        command << ['--content', content]
        command << ['--title', title] if title
        command << ['--id', id] if id
        command << '--sound' if sound
        command << ['--priority', priority] if priority
        command << ['--vibrate', vibrate] if vibrate
        command << ['--led-color', led_colour] if led_colour
        command << ['--led-on', led_on] if led_on
        command << ['--led-off', led_off] if led_off
        command << ['--action', action] if action
        command << ['--on-delete', on_delete_action] if on_delete_action
        command << ['--button1', button_1] if button_1
        command << ['--button1-action', button_1_action] if button_1_action
        command << ['--button2-action', button_2_action] if button_2_action
        command << ['--button3-action', button_3_action] if button_3_action
        command.flatten!

        Open3.capture2(*command)
      end
    end
  end
end
