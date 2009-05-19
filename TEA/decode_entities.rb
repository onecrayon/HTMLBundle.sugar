#!/usr/bin/env ruby
$KCODE = 'U'

$entity_to_char = { }
File.open("#{ENV['E_SUGARPATH']}/Support/entities.txt").read.scan(/^(\d+)\t(.+)$/) do |key, value|
  $entity_to_char[value] = [key.to_i].pack('U')
end

res = STDIN.read.gsub(/&(?:([a-z0-9]+)|#([0-9]+)|#x([0-9A-F]+));/i) do |m|
  if $1 then
    $entity_to_char[$1] || m
  else
    [$2 ? $2.to_i : $3.hex].pack("U")
  end
end

print res
