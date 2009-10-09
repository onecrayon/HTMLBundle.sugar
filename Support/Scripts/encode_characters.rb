#!/usr/bin/env ruby

print STDIN.read.gsub(/./) {sprintf("&#x%02X;", $&.unpack("U")[0])}
