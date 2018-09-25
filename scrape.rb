require 'open-uri'
require 'nokogiri'
require 'pry'

def get_doc(index_url)
  @doc = Nokogiri::HTML(open(index_url))
  @subway_table = @doc.css('#subwayDiv')[0].css('table')

  @subway_table.search('tr').each do |tr|
    cells = tr.search('th, td')

    if cells[0].css('img')[0]
      #subway line
      p cells[0].css('img')[0].attributes["alt"].value

      #delay or not? delay would return an nokogiri::xml::element. not would be an empty array
      cells[1].css('.subway_delays').empty? ? (p "Not Delayed") : (p "Delays")
    end

  end
end

get_doc('http://service.mta.info/ServiceStatus/status.html')