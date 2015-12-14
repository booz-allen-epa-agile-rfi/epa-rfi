module AssociationResolution
  extend ActiveSupport::Concern

  included do
    attr_reader :render_params
    before_action :set_association_inclusions!
  end

  protected

  def query_with_includes(query)
    return query if @association_inclusions.empty?
    @association_inclusions.keys.inject(query) { |a, e| a.includes(e) }
  end

  def set_association_inclusions!
    @association_inclusions = {}
    (params[:includes] || []).each { |inc| @association_inclusions[inc.to_sym] = {} }
    @render_params ||= {}
    @render_params[:include] = @association_inclusions
  end

  def entity_resolution_error(e)
    format.json do
      render json: { error: e.message }
    end
  end
end
