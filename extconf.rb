require 'mkmf'
exec 'bash bootstrap.sh'
puts Dir.pwd
File.open("Makefile", 'w') { |file| file.puts(dummy_makefile('.')) }
