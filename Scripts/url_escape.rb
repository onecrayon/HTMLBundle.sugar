#!/usr/bin/env ruby

print STDIN.read.gsub(/([^a-zA-Z0-9_.-]+)/n) {
  '%' + $1.unpack('H2' * $1.size).join('%').upcase
}
