module RenderWithParams
  extend ActiveSupport::Concern

  def respond_with_params(item, r_params = {})
    @render_params ||= {}
    @render_params.merge! r_params

    respond_with item, @render_params
  end
end
