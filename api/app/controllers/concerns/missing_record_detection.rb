module MissingRecordDetection
  module Messages
    class << self
      def not_found
        'Not found.'.freeze
      end
    end
  end

  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  end

  module ClassMethods
  end

  def record_not_found
    render json: { error: MissingRecordDetection::Messages.not_found }, status: 404
  end
end
