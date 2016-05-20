require 'open-uri'
#require 'nokogiri'
require 'csv'


class ApplicationController < ActionController::Base
	protect_from_forgery

	class Name
		def initialize(name, link,phone_no,contact_address)
			@name = name
			@link = link
			@phone_no = phone_no
			@contact_address	=	contact_address
		end
		attr_reader :name
		attr_reader :link
		attr_reader :phone_no
		attr_reader :contact_address
	end

	def scrape_web
    #render text: 'scrape reddit data here'
    #doc = Nokogiri::HTML(open("https://www.reddit.com/"))
    main = "http://www.arabiantravelmarket.com"
    url = "http://www.arabiantravelmarket.com/en/exhibitor-directory/"
    #doc = Nokogiri::HTML(open("http://www.arabiantravelmarket.com/en/exhibitor-directory/").read, nil, 'utf-8')
    #render text: doc

    #entries = doc.css('.name>a')
    #en = doc.css('.name>a').text
    @entriesArray = []

    i = 0
    max = 2533


begin
    while i < max  
    	if i == 0
    		doc = Nokogiri::HTML(open(url).read, nil, 'utf-8')
    		entries = doc.css('.name>a')
    		i+=13
    	else
    		next_page_url = url + "?startRecord=#{i}&rpp=12"
    		doc = Nokogiri::HTML(open(next_page_url).read, nil, 'utf-8')
    		entries = doc.css('.name>a')
    		i+=12
    	end
    	entries.each do |entry|
    		link  = entry['href']

    		agent_link = main + link
    		agent_page_info = Nokogiri::HTML(open(agent_link).read, nil, 'utf-8')
    	##name***************
    	name = agent_page_info.css('.exhibitorName').text
    	####link **********
    	temp = agent_page_info.css('.web > a')
    	if temp.length != 0
    		web_link = temp[0]['href']
    	end

        ####Phone number **********
        phone_no = agent_page_info.css('.tel').text.split.join(' ')

    	####address **********
    	address = agent_page_info.css('.adr').text.split.join(' ')

    	@entriesArray << Name.new(name, web_link,phone_no,address)
    end
end


CSV.open("listed_data.csv", "w") do |csv|
    csv << ["Name", "Link", "Phone No", "Contact Address"]
    @entriesArray.each do |entry|
        csv << [entry.name,entry.link,entry.phone_no,entry.contact_address]
    end
end
rescue
end
    #render text: entriesArray
    render template: 'scrape_web'

end
end
