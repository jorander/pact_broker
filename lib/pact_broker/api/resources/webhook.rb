require 'pact_broker/services'
require 'pact_broker/api/decorators/webhook_decorator'

module PactBroker::Api

  module Resources

    class Webhook < BaseResource

      def content_types_provided
        [["application/hal+json", :to_json]]
      end

      def allowed_methods
        ["GET"]
      end

      def resource_exists?
        !webhook.nil?
      end

      def to_json
        Decorators::WebhookDecorator.new(webhook).to_json(base_url: resource_url)
      end

      def webhook
        @webhook ||= webhook_service.find_by_uuid uuid
      end

      def uuid
        identifier_from_path[:uuid]
      end

    end
  end

end
