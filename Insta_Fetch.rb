=begin
	
	enumerate links
		Loop check if more_available = "false" continue else exit loop
		send_request
		last id
		image url
		return links and last id
	populate array with links
	return array of links
	
	Send request
		send request to URL
		parse json
		return hashmap

=end


require 'json'
require 'open-uri'

BASE_uRL = "https://www.instagram.com"

def send_request(username, max_id)
	url = "#{BASE_uRL}/#{ username }/media/?__a=1"
	
	params = ""
	params = "&max_id=#{max_id}" if max_id
	
	# Return Hashmap of request
	JSON.parse( open("#{url}#{params}", {ssl_verify_mode:0}).read )
end

def collect_links()

end

links = []
more_available = true
max_id = " "

while more_available == true do
	data = send_request('sssniperwolf', max_id)
	sleep(5)
	items = data.fetch("items")
	more_available = data.fetch("more_available")
	max_id = items.last()["id"].split("_")[0]
	items.each do |item|
		links << item["images"]["standard_resolution"]["url"]
		puts links
	end
end

File.open("url.txt", 'w') do |file| 
	links.each do |link|
		file.puts link
	end
end
