require 'mkmf'
exec 'bash bootstrap.sh'
File.open("Makefile", 'w') { |file| file.puts(dummy_makefile('.')) }
