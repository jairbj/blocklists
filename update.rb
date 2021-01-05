filename = "lists/only_domains/dohservers.txt"

# Prepare directories
Dir.mkdir("lists") unless File.exists?("lists")
Dir.mkdir("lists/only_domains") unless File.exists?("lists/only_domains")

# New server list
server_list = []

# Get old server list for merge
if File.exists?(filename)
  file = File.open(filename).read
  file.split("\n").each do |line|
    server_list << line unless line.start_with? "#"
  end
end

# Reads the new file
require 'open-uri'
file = open('https://raw.githubusercontent.com/wiki/curl/curl/DNS-over-HTTPS.md').read

header = [
  "#",
  "# Use at your own risk. Not responsible for errors, updates or issues this may cause",
  "#"
]


list = file.match(/# Publicly available servers(.*)Tested via/m)[1]
list.split("\n").each do | line | 
  line.match(/\|.+?\|(.+?)\|/) do |m| 
    servers = m.captures[0].scan(/https:\/\/(.+?)[ \/\\|\(\)\:]/)
    servers.each do |s|
      server_list += s
    end
  end
end

server_list.uniq!
server_list.sort!

File.open(filename, "w+") do |f| 
  f.puts(header) 
  f.puts(server_list) 
end
