#!/usr/bin/env ruby -wKU
STDOUT.sync = true

page = STDIN.read
page.gsub!(/<\?(php|=).*?\?>|<%.*?%>/m, '')

open('|curl -sF uploaded_file=@-\;type=text/html http://validator.w3.org/check', 'r+') do |io|
  io << page; io.close_write

  result = io.read

  result.gsub!(/<\/title>/, '\&<base href="http://validator.w3.org/">')
#  result.gsub!(/Line (\d+),?\s*Column (\d+)/mi) do
#    "<a href=\"txmt://open?line=#$1&amp;column=#{$2.to_i + 1}\">#$&</a>"
#  end
  puts result
end
