#!/usr/bin/env ruby -wKU
STDOUT.sync = true

page = STDIN.read
page.gsub!(/<\?(php|=).*?\?>|<%.*?%>/m, '')

open('|curl -sF uploaded_file=@-\;type=text/html http://validator.w3.org/check', 'r+') do |io|
  io << page; io.close_write

  result = io.read

  result.gsub!(/<\/title>/, '\&<base href="http://validator.w3.org/">')
  if ENV['EDITOR_PATH'] != ''
    result.gsub!(/Line (\d+),?\s*Column (\d+)/mi) do
      "<a href=\"x-espresso://open?filepath=#{ENV['EDITOR_PATH']}&amp;lines=#$1\">#$&</a>"
    end
  end
  puts result
end
