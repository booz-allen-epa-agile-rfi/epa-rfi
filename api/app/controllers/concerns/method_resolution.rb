module MethodResolution
  extend ActiveSupport::Concern

  included do
    before_action :set_method_inclusions!
  end

  module ClassMethods
  end

  protected

  def model_methods
    @model_method_symbols ||= controller_name.classify.constantize.methods
  end

  def set_method_inclusions!
    raw_inclusion = params[:methods] || []
    @method_inclusions = raw_inclusion.map(&:to_sym)
    @render_params ||= {}
    @render_params[:methods] = @method_inclusions
  end

  def entity_resolution_error(e)
    format.json do
      render json: { error: e.message }
    end
  end
end
