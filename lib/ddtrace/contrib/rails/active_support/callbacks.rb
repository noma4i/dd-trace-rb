module Datadog
  module Contrib
    module Rails
      module ActiveSupport
        module Callbacks
          module CallbackChain
            def compile
              binding.pry
              super
            end

            def trace_callback
            end
          end
        end
      end
    end
  end
end
