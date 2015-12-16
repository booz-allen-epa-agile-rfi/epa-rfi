class EpaRecordsController < ApplicationController
  wrap_parameters false

  def index
    render json: geoJSONify(epa_records)
  end

  api :POST, '/search', 'Searches EPA records by county, state, chemical, year, emissions or bounds.'
  param :facility_county, String, required: false, desc: 'Facility county name.'
  param :facility_state, String, required: false, desc: 'Facility two character state abbreviation.'
  param :chemical_name, String, required: false, desc: 'Chemical name.'
  param :reporting_year, Array, required: false, desc: 'An array of years reported on.'
  param :emissions, Array, required: false, in: %w(land air), desc: 'An array of emissions contain either land or air'
  param :bounds, Array, required: false, desc: 'An array of longitude and latitude in the format of SX, SY, NX, NY'
  error code: 404, desc: MissingRecordDetection::Messages.not_found

  def search
    response = geoJSONify(epa_records)

    if response
      render json: response
    else
      render json: {status: 'error', data: [], message: 'No records found'}, status: 404
    end
  end

  api :GET, '/states', 'Returns an array of objects with all states in the EPA records.'

  def states
    render json: epa_records
  end

  api :GET, '/chemicals', 'Returns an array of objects with all chemicals in the EPA records.'

  def chemicals
    render json: epa_records
  end

  api :GET, '/zip_codes', 'Returns an array of objects with all zip codes, counties and states in the EPA records.'

  def zip_codes
    render json: epa_records
  end

  api :GET, '/counties', 'Returns an array of objects with all counties in the EPA records.'

  def counties
    render json: epa_records
  end

  api :GET, '/county_totals', 'Returns an array of objects with the state, county, total number of records for that county, total pollutants and each pollutants value in the EPA records.'

  def county_totals
    render json: epa_records
  end

  api :GET, '/state_counties/:state', 'Returns an array of objects with all counties in the EPA records for a given :state.'
  param :state, String, required: true, desc: 'Facility two character state abbreviation.'

  def state_counties
    render json: epa_records
  end

  api :GET, '/years', 'Returns an array of objects with all years in the EPA records.'

  def years
    render json: epa_records
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
      when 'states'
        EpaRecord.states
      when 'chemicals'
        EpaRecord.chemicals
      when 'zip_codes'
        EpaRecord.zip_codes
      when 'counties'
        EpaRecord.counties
      when 'county_totals'
        EpaRecord.county_totals
      when 'state_counties'
        EpaRecord.state_counties(params[:state])
      when 'years'
        EpaRecord.years
      when 'search'
        params = epa_params
        emissions_conditions = search_emissions(params[:emissions]) unless params[:emissions].nil?
        bounds_conditions = search_bounds(params[:bounds]) unless params[:bounds].nil?

        query_with EpaRecord.search.where(params).emissions(emissions_conditions).bounds(bounds_conditions)
      else
        EpaRecord.all
      end
    end
  end

  private

  def search_emissions(emissions)
    # QUERY WITH EMISSIONS
    emissions = emissions

    select_conditions = []

    if emissions.include? 'air'
      select_conditions << 'total_air_emissions > 0'
    end

    if emissions.include? 'land'
      select_conditions << 'total_underground_injection > 0'
      select_conditions << 'total_on_site_land_releases > 0'
    end

    epa_params.delete('emissions')
    select_conditions
  end

  def search_bounds(bounds)
    # QUERY WITH BOUNDS
    bounds = bounds

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
    select_conditions
  end

  def epa_params
    @_epa_params ||= params.permit(:facility_county, :facility_state, :chemical_name, reporting_year: [], emissions: [], bounds: [])
  end

  def geoJSONify(records)
    return if records.blank?

    geoJSON = {type: "FeatureCollection", features: []}
    records.each do |r|
      coords = [r.longitude.to_f, r.latitude.to_f]
      geoJSON[:features] << {type: "Feature", properties: r, geometry: {
        type: 'Point',
        coordinates: coords
        } }
    end
    geoJSON
  end
end
