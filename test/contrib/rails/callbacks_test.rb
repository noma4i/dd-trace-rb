require 'helper'

require 'contrib/rails/test_helper'

# rubocop:disable Metrics/ClassLength
class CallbacksControllerTest < ActionController::TestCase
  setup do
    @original_tracer = Datadog.configuration[:rails][:tracer]
    @tracer = get_test_tracer
    Datadog.configuration[:rails][:tracer] = @tracer
  end

  teardown do
    Datadog.configuration[:rails][:tracer] = @original_tracer
  end

  test 'request is properly traced' do
    get :index
    assert_response :success
    spans = @tracer.writer.spans
    assert_equal(3, spans.length)

    span = spans[0]
    assert_equal(span.name, 'rails.action_controller')
    assert_equal(span.span_type, 'http')
    assert_equal(span.resource, 'CallbacksController#index')
    assert_equal(span.get_tag('rails.route.action'), 'index')
    assert_equal(span.get_tag('rails.route.controller'), 'CallbacksController')
  end
end
