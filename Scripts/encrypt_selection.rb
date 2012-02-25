#!/usr/bin/env ruby

def e_js(str)
  str.gsub(/(?=[\\"])/, '\\').gsub(/\n/, '\n').gsub(/[@.\/]/) { |ch| sprintf('\\%03o', ch[0]) }
end

def rot_13(str)
  str.tr('A-Za-z', 'N-ZA-Mn-za-m')
end

print %{<script type="text/javascript">document.write(
"#{e_js(rot_13(STDIN.read))}".replace(/[a-zA-Z]/g, function(c){return String.fromCharCode((c<="Z"?90:122)>=(c=c.charCodeAt(0)+13)?c:c-26);}));
</script>}
