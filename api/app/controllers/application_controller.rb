class ApplicationController < ActionController::Base
  respond_to :json

  # Response Rending
  include RenderWithParams
  include MethodResolution
  include MissingRecordDetection

  # Querying
  include AssociationResolution
  include QueryBuilder


  extend Apipie::DSL::Concern
end
