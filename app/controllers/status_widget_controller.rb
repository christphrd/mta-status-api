require 'byebug'

class StatusWidgetController < ApplicationController
  def lines_status
    require 'openssl'
    doc = Nokogiri::HTML(open('http://service.mta.info/ServiceStatus/status.html', :ssl_verify_mode => OpenSSL::SSL::VERIFY_NONE))


    # @index_url = index_url
    # @doc = Nokogiri::HTML(open(index_url))
    subway_table = doc.css('#subwayDiv')[0].css('table')

    subway_table.search('tr').each do |tr|
    cells = tr.search('th, td')

    if cells[0].css('img')[0]
      #subway line
      p cells[0].css('img')[0].attributes["alt"].value

      #delay or not? delay would return an nokogiri::xml::element. not would be an empty array
      p cells[1].css('.subway_delays')
    end

    end
    render 
  end

  def status
    byebug
  end

  
end
