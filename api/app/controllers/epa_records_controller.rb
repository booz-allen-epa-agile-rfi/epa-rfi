class EpaRecordsController < ApplicationController
  def index
    render json: geoJSONify(epa_records)
  end

  def search
    render json: geoJSONify(epa_records)
  end

  def states_list
    render json: geoJSONify(epa_records)
  end

  def chemicals
    render json: geoJSONify(epa_records)
  end

  def zip_codes
    render json: geoJSONify(epa_records)
  end

  def counties_list
    render json: geoJSONify(epa_records)
  end

  def county_totals
    render json: geoJSONify(epa_records)
  end

  def state_counties
    render json: geoJSONify(epa_records)
  end

  # INTENTIONALLY LEAVING OUT CREATE, UPDATE AND DESTROY SINCE WE ARE WORKING OFF STATIC DATA

  private

  def epa_record
    @_epa_record ||= begin
      (EpaRecord.where(id: params[:id]).empty?) ? {} : EpaRecord.find(params[:id])
    end
  end

  def epa_records
    @_epa_records ||= begin
      case params['action']
      when 'states_list'
        EpaRecord.states_list
      when 'chemicals'
        EpaRecord.chemicals
      when 'zip_codes'
        EpaRecord.zip_codes
      when 'counties_list'
        # EpaRecord.counties_list
        Counties.includes(:states).all
      when 'county_totals'
        EpaRecord.county_totals
      when 'state_counties'
        EpaRecord.state_counties(params[:state])
      when 'search'
        query_with EpaRecord.where(epa_params)
      else
        EpaRecord.all
      end
    end
  end

  def epa_params
    @_epa_params ||= params.permit(:chemical_name, reporting_year: [], emissions: [], bounds: [])
  end

  def geoJSONify(records)
    geoJSON = {type: "FeatureCollection", features: []}
    records.each do |r|
      geoJSON[:features] << {type: "Feature", properties: r }
    end
    geoJSON
  end
end
