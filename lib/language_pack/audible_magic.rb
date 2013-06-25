module LanguagePack
  module AudibleMagic
    AUDIBLE_MAGIC_VERSION = "7.5_20.8_linux64"
    AUDIBLE_MAGIC_URL     = "https://overlord.alex.audiosocket.com.s3.amazonaws.com/audible_magic/amSigGen-#{AUDIBLE_MAGIC_VERSION}.tgz"

    def slug_audible_magic_path
      "vendor/audible-magic"
    end

    def install_audible_magic
      topic "Installing Audible Magic Signal Generator"
      
      FileUtils.mkdir_p slug_audible_magic_path
      Dir.chdir slug_audible_magic_path do
        run("curl #{AUDIBLE_MAGIC_URL} -s -o - | tar zxf - --strip-components=1")

        Dir["bin/*"].each {|path| run("chmod +x #{path}") }
      end

      error "Error installing Audible Magic" unless $?.success?

      bin_dir = "bin"

      FileUtils.mkdir_p bin_dir
      
      File.open("#{bin_dir}/amSigGen", "w") do |file|
        file.puts <<-AMSIGGEN
#!/bin/bash

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$HOME/#{slug_audible_magic_path}/lib

(cd $HOME/#{slug_audible_magic_path}/bin && exec ./amSigGen "$@")

AMSIGGEN
      end

      true
      
    end
  end
end
