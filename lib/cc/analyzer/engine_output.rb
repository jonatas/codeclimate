module CC
  module Analyzer
    class EngineOutput
      delegate :blank?, to: :raw_output
      delegate :to_json, to: :as_issue

      def initialize(raw_output)
        @raw_output = raw_output
      end

      def issue?
        parsed_output &&
          parsed_output["type"].present? &&
          parsed_output["type"].downcase == "issue"
      end

      def as_issue
        Issue.new(raw_output)
      end

      private

      attr_accessor :raw_output

      def parsed_output
        JSON.parse(raw_output)
      rescue JSON::ParserError
        nil
      end
    end
  end
end
