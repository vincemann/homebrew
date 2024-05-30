class SubtitleBuddy < Formula
  desc "Opensource Subtitle Player"
  homepage "https://github.com/vincemann/subtitle-buddy"

   if OS.mac?
    url "http://192.168.178.69:8000/image-mac.zip"
    sha256 "1ed7f332ed7c839a99d43c88066b448e914c09a9acd0db339fe3d3fa06e85311"
  elsif OS.linux?
    url "http://192.168.178.69:8000/image-linux.zip"
    sha256 "05aeb52e7fe5e09c1fc37face70a061381cb016eac99b79e5837fab4f82c0596"
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
