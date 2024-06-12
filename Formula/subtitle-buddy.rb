class SubtitleBuddy < Formula
  desc "Opensource Subtitle Player"
  homepage "https://github.com/vincemann/subtitle-buddy"
  download_host = "https://github.com/vincemann/subtitle-buddy/releases/download/2.0.0"
  version="2.0.0"

  # supports linux x64, mac x64 & mac aarch64
  if OS.mac?
    if Hardware::CPU.arm?
      url "#{download_host}/subtitle-buddy-#{version}-mac-aarch64-image.zip"
      sha256 "be57e97aeac04c473402131d907bc582f7fa58081d7a2f258160a88207443346"
    else
      url "#{download_host}/subtitle-buddy-#{version}-mac-image.zip"
      sha256 "3caa4c52f92c34ec17db291d24a853a737caf59d9d2573c5b4d97da556ea202f"
    end
  elsif OS.linux?
    url "#{download_host}/subtitle-buddy-#{version}-linux-image.zip"
    sha256 "860d36ed7446521df6578179acc88314c44c0c8cf2bc37619199b4b2a6ca28ee"
  end


  def install
    # Extract the zip file to the libexec directory
    libexec.install Dir["*"]

    # Install the launch script by creating a symlink in Homebrew's bin directory
    bin.install_symlink libexec/"bin/appLauncher" => "subtitle-buddy"
  end

  def post_install
    if OS.mac?
      # URLs to the correct libraries
      download_host = "https://github.com/vincemann/subtitle-buddy/raw/master/server"
      jnativehook_arm64_url = "#{download_host}/libJNativeHook_arm64.dylib"
      jnativehook_x86_64_url = "#{download_host}/libJNativeHook_x86_64.dylib"
      libjvm_url = "#{download_host}/libjvm.dylib"
      libjsig_url = "#{download_host}/libjsig.dylib"

      # Download and replace the necessary files using curl
      system "curl", "-L", "-o", "#{libexec}/lib/jnativehook/darwin/arm64/libJNativeHook.dylib", jnativehook_arm64_url
      system "curl", "-L", "-o", "#{libexec}/lib/jnativehook/darwin/x86_64/libJNativeHook.dylib", jnativehook_x86_64_url
      system "curl", "-L", "-o", "#{libexec}/lib/server/libjvm.dylib", libjvm_url
      system "curl", "-L", "-o", "#{libexec}/lib/server/libjsig.dylib", libjsig_url

      # Ensure the files have the correct permissions
      chmod 0755, "#{libexec}/lib/jnativehook/darwin/arm64/libJNativeHook.dylib"
      chmod 0755, "#{libexec}/lib/jnativehook/darwin/x86_64/libJNativeHook.dylib"
      chmod 0755, "#{libexec}/lib/server/libjvm.dylib"
      chmod 0755, "#{libexec}/lib/server/libjsig.dylib"
    end
  end

  test do
    # The test block ensures the symlink exists and points to an executable file
    assert_predicate bin/"subtitle-buddy", :executable?, "Subtitle Buddy should be executable"
    
    # Run the version command and check if it returns the correct version
    output = shell_output("#{bin}/subtitle-buddy --version")
    assert_match "Version: #{version}", output.strip, "Version output should match the expected version"
  end
end
