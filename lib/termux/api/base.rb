module Termux
  module API
    class Base
      def self.run
        raise 'You need to overload the .run method'
      end
    end
  end
end

