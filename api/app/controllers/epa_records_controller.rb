class EpaRecordsController < ApplicationController
  wrap_parameters false

  def index
    render json: geoJSONify(epa_records)
  end

  error code: 404, desc: MissingRecordDetection::Messages.not_found

  def search
    response = geoJSONify(epa_records)

    if response
      render json: response
    else
      render json: {status: 'error', data: [], message: 'No records found'}, status: 404
    end
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
        if params[:bounds].nil? && params[:emissions].nil?
          query_with EpaRecord.where(epa_params.each { |k, v| epa_params[k] = v.upcase })
        elsif params[:bounds].nil?
          # QUERY WITH EMISSIONS
          emissions = params[:emissions]

          select_conditions = []

          if emissions.include? 'air'
            select_conditions << 'total_air_emissions > 0'
          end

          if emissions.include? 'land'
            select_conditions << 'total_underground_injection > 0'
            select_conditions << 'total_on_site_land_releases > 0'
          end

          epa_params.delete('emissions')
          query_with EpaRecord.where(epa_params).where(select_conditions.join(' OR '))
        else
          # QUERY WITH BOUNDS
          bounds = params[:bounds]

          # GET SOUTH WEST COORDINATE
          sx = bounds.first.to_f
          sy = bounds.second.to_f

          # GET NORTH EAST COORDINATE
          nx = bounds.third.to_f
          ny = bounds.fourth.to_f

          # RECTANGLE CONDITIONS
          select_conditions = []
          select_conditions << "longitude <= #{ny}"
          select_conditions << "longitude >= #{sy}"
          select_conditions << "latitude <= #{nx}"
          select_conditions << "latitude >= #{sx}"
          epa_params.delete('bounds')
          query_with EpaRecord.where(epa_params).where(select_conditions.join(' and '))
        end
      else
        EpaRecord.all
      end
    end
  end

  def epa_params
    @_epa_params ||= params.permit(:facility_county, :chemical_name, reporting_year: [], emissions: [], bounds: [])
  end

  def geoJSONify(records)
    return if records.blank?

    geoJSON = {type: "FeatureCollection", features: []}
    records.each do |r|
      coords = [r.longitude.to_f || 0, r.latitude.to_f || 0]
      geoJSON[:features] << {type: "Feature", properties: r, geometry: {
        type: 'Point',
        coordinates: coords
        } }
    end
    geoJSON
  end
end
