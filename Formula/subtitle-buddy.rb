class SubtitleBuddy < Formula
  desc "Opensource Subtitle Player"
  homepage "https://github.com/vincemann/subtitle-buddy"
  download_host = "http://192.168.178.69:8000"
  version="1.1.0"

  # supports linux x64, mac x64 & mac aarch64
  if OS.mac?
    if Hardware::CPU.arm?
      url "#{download_host}/subtitle-buddy-#{version}-mac-aarch64-image.zip"
      sha256 "aarch64-specific-sha256-checksum-here"
    else
      url "#{download_host}/subtitle-buddy-#{version}-mac-x64-image.zip"
      sha256 "8556ae618b2dc7b78f02a9e1c32b2c67d87beca001baa6e429e305a4dde42494
f7bf7806747b5095790aeb9a20e68d622ad1656bd4ab51a58f3739baa644b68f"
    end
  elsif OS.linux?
    url "#{download_host}/subtitle-buddy-#{version}-linux-image.zip"
    sha256 "8f424d0a4db0806650ecf0089accd881a50afb2eba500f45358fc2c36d202d43"
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
      download_host = "http://192.168.178.69:8000"
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
