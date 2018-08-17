require 'rufus-scheduler'
require 'open-uri'
require 'nokogiri'
require 'byebug'

scheduler = Rufus::Scheduler::singleton
DELAYED = {}

scheduler.every '5s' do
  # do stuff
  doc = Nokogiri::HTML(open('http://service.mta.info/ServiceStatus/status.html', :ssl_verify_mode => OpenSSL::SSL::VERIFY_NONE))
  subway_table = doc.css('#subwayDiv')[0].css('table')

  if DELAYED.empty?
    subway_table.search('tr').each do |tr|
      cells = tr.search('th, td')
      if cells[0].css('img')[0]
        #subway line
        p cells[0].css('img')[0].attributes["alt"].value
  
        #delay or not? delay would return an arr of nokogiri::xml::element. not would be an empty array
        p !cells[1].css('.subway_delays').empty?
        DELAYED[cells[0].css('img')[0].attributes["alt"].value] = !cells[1].css('.subway_delays').empty?

      end
    end
  else
    subway_table.search('tr').each do |tr|
      cells = tr.search('th, td')
      if cells[0].css('img')[0]
        line = cells[0].css('img')[0].attributes["alt"].value
        if DELAYED[line] != !cells[1].css('.subway_delays').empty? && !cells[1].css('.subway_delays').empty?
          DELAYED[line] = !DELAYED[line]
          p "#{line} is experiencing delays"
        elsif DELAYED[line] != !cells[1].css('.subway_delays').empty? && cells[1].css('.subway_delays').empty?
          DELAYED[line] = !DELAYED[line]
          p "#{line} is recovered"
        end
      end
    end
  end

end