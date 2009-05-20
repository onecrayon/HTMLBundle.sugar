#!/usr/bin/env sh

## Strip HTML and PHP tags from the selected text
php -r 'echo strip_tags( file_get_contents("/dev/stdin") );'

###  If you want to keep a particular tag, such as <p> comment the above line and uncomment the next line
# php -r 'echo strip_tags( file_get_contents("/dev/stdin"), "<p>" );'
### end