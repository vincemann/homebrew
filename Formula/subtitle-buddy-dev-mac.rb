class SubtitleBuddyDevMac < Formula
  desc "Opensource Subtitle Player"
  homepage "https://github.com/vincemann/subtitle-buddy"
  url "http://192.168.178.69:8000/subtitle-buddy-1.1.0-macx64.tar.gz"
  sha256 "cec8cf942befe757e89e79d2dbb93dedd48c54859905dfd0612049a405956055"

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
