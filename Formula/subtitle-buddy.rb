class SubtitleBuddy < Formula
  desc "Opensource Subtitle Player"
  homepage "https://github.com/vincemann/subtitle-buddy"

   if OS.mac?
    url "https://example.com/subtitle-buddy-mac-1.1.0.tar.gz"
    sha256 ""
  elsif OS.linux?
    url "https://example.com/subtitle-buddy-linux-1.1.0.tar.gz"
    sha256 "4d852b7b0b36a0bdd87c05bfe60d8bff32758c42f282f2e24d683358ac726cac"
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
