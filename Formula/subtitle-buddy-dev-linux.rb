class SubtitleBuddyDevLinux < Formula
  desc "Opensource Subtitle Player"
  homepage "https://github.com/vincemann/subtitle-buddy"
  url "http://localhost:8000/subtitle-buddy-1.1.0-linuxx64.tar.gz"
  sha256 "ebf295b7a60a240aaf8d55be588043b07058fe717af07e836fbca49f33b409e6"

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
