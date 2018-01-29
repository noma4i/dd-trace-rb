module Datadog
  module Contrib
    module Rails
      module ActionController
        module Callbacks
          def self.included(base)
            # base.include(InstanceMethods)
            # base.extend(ClassMethods)
            base.class_eval do
              include InstanceMethods
            end
            puts base.method(:_process_action_callbacks).source_location
            binding.pry
          end

          module InstanceMethods
            def _process_action_callbacks
              binding.pry
              self.class._process_action_callbacks
            end
          end

          module ClassMethods
            def _process_action_callbacks
              binding.pry
              super
            end

            def set_callback(name, *filter_list, &block)
              binding.pry
              super
            end

            def set_callbacks(name, callbacks)
              binding.pry
              callbacks.extend(Datadog::Contrib::Rails::ActiveSupport::Callbacks::CallbackChain)
              callbacks.blah
              super(name, callbacks)
            end

            # def run_callbacks(kind, &block)
            #   # Wrap the callback chain
            #   # NOTE: Doing this for every call sucks... bad for performance.
            #   #       Can we modify the callback objects for this controller only,
            #   #       without monkey patching ALL ActiveSupport::Callbacks?
            #   callbacks = self.class.send(:get_callbacks, kind)
            #   traced_callbacks = callbacks # TODO: Replace
            #   self.class.send(:set_callbacks, kind, traced_callbacks)

            #   super
            # end
          end
        end
      end
    end
  end
end
