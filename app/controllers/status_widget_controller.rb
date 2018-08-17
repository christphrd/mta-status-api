require 'open-uri'
require 'nokogiri'
require 'byebug'

class StatusWidgetController < ApplicationController
  def lines_status
    require 'openssl'
    doc = Nokogiri::HTML(open('http://service.mta.info/ServiceStatus/status.html', :ssl_verify_mode => OpenSSL::SSL::VERIFY_NONE))
    subway_table = doc.css('#subwayDiv')[0].css('table')

    subway_table.search('tr').each do |tr|
      cells = tr.search('th, td')
      if cells[0].css('img')[0]
        #subway line
        p cells[0].css('img')[0].attributes["alt"].value

        #delay or not? delay would return an arr of nokogiri::xml::element. not would be an empty array
        p cells[1].css('.subway_delays')
      end
    end
  end

  def status
    doc = Nokogiri::HTML(open('http://service.mta.info/ServiceStatus/status.html'))
    subway_table = doc.css('#subwayDiv')[0].css('table')
    rows = subway_table.search('tr')

    line = params[:id].upcase
    if line == "1" || line == "2" || line == "3"
      delay = rows[1].css('.subway_delays')
      render json: {currentlyDelayed: !delay.empty?}
    elsif line == "4" || line == "5" || line == "6"
      delay = rows[2].css('.subway_delays')
      render json: {currentlyDelayed: !delay.empty?}
    elsif line == "7"
      delay = rows[3].css('.subway_delays')
      render json: {currentlyDelayed: !delay.empty?}
    elsif line == "A" || line == "C" || line == "E"
      delay = rows[4].css('.subway_delays')
      render json: {currentlyDelayed: !delay.empty?}
    elsif line == "B" || line == "D" || line == "F" || line == "M"
      delay = rows[5].css('.subway_delays')
      render json: {currentlyDelayed: !delay.empty?}
    elsif line == "G"
      delay = rows[6].css('.subway_delays')
      render json: {currentlyDelayed: !delay.empty?}
    elsif line == "J" || line == "Z"
      delay = rows[7].css('.subway_delays')
      render json: {currentlyDelayed: !delay.empty?}
    elsif line == "L"
      delay = rows[8].css('.subway_delays')
      render json: {currentlyDelayed: !delay.empty?}
    elsif line == "N" || line == "Q" || line == "R"
      delay = rows[9].css('.subway_delays')
      render json: {currentlyDelayed: !delay.empty?}
    elsif line == "S"
      delay = rows[10].css('.subway_delays')
      render json: {currentlyDelayed: !delay.empty?}
    elsif line == "SIR"
      delay = rows[11].css('.subway_delays')
      render json: {currentlyDelayed: !delay.empty?}
    else
      render json: {error: "404 Not Found"}
    end
    
  end

  
end
