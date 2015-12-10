class EpaRecordsController < ApplicationController

  def index
    render json: epa_records
  end

  def show
    render json: epa_record
  end

  def states
    render json: epa_records
  end

  def chemicals
    render json: epa_records
  end

  def zip_codes
    render json: epa_records
  end

  def counties
    render json: epa_records
  end

  def county_totals
    render json: epa_records
  end

  def state_counties
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
      else
        EpaRecord.all
      end
    end
  end
end
