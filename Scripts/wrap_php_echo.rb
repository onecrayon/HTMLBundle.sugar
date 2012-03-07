#!/usr/bin/env ruby

print '<?= ${1:' + STDIN.read.strip.gsub(/(\$|\{|\}|\\|`)/){ "\\#{$1}" } + '} ?>'
