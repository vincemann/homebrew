class SubtitleBuddy < Formula
  desc "Opensource Subtitle Player"
  homepage "https://github.com/vincemann/subtitle-buddy"

   if OS.mac?
    url "http://192.168.178.69:8000/subtitle-buddy-1.1.0-macx64.tar.gz"
    sha256 "570fab7d3c231bd03e4998666b533f890ca64c52a4f2de04eebb953243e3c4b9"
  elsif OS.linux?
    url "http://192.168.178.69:8000/subtitle-buddy-1.1.0-linuxx64.tar.gz"
    sha256 ""
  end

  def install
    # Extract the tarball to the libexec directory
    libexec.install Dir["*"]

    # Install the launch script by creating a symlink in Homebrew's bin directory
    bin.install_symlink libexec/"bin/appLauncher" => "subtitle-buddy"
  end

  test do
    # The test block ensures the symlink exists and points to an executable file
    assert_predicate bin/"subtitle-buddy", :executable?, "Subtitle Buddy should be executable"
  end
end
