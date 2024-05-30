class SubtitleBuddy < Formula
  desc "Opensource Subtitle Player"
  homepage "https://github.com/vincemann/subtitle-buddy"
  download_host = "http://192.168.178.69:8000"

  if OS.mac?
    url "#{download_host}/image-mac.zip"
    sha256 "1ed7f332ed7c839a99d43c88066b448e914c09a9acd0db339fe3d3fa06e85311"
  elsif OS.linux?
    url "#{download_host}/image-linux.zip"
    sha256 "05aeb52e7fe5e09c1fc37face70a061381cb016eac99b79e5837fab4f82c0596"
  end

  def install
    # Extract the zip file to the libexec directory
    libexec.install Dir["*"]

    # Install the launch script by creating a symlink in Homebrew's bin directory
    bin.install_symlink libexec/"bin/appLauncher" => "subtitle-buddy"
  end

  def post_install
    if OS.isMac?
      # homebrew corrupts some files, so I need to manually replace them...
      download_host = "http://192.168.178.69:8000"
      jnativehook_arm64_url = "#{download_host}/libJNativeHook_arm64.dylib"
      jnativehook_x86_64_url = "#{download_host}/libJNativeHook_x86_64.dylib"
      libjvm_url = "#{download_host}/libjvm.dylib"
      libjsig_url = "#{download_host}/libjsig.dylib"

      # Download and replace the necessary files
      system "wget", "-O", "#{libexec}/lib/jnativehook/darwin/arm64/libJNativeHook.dylib", jnativehook_arm64_url
      system "wget", "-O", "#{libexec}/lib/jnativehook/darwin/x86_64/libJNativeHook.dylib", jnativehook_x86_64_url
      system "wget", "-O", "#{libexec}/lib/server/libjvm.dylib", libjvm_url
      system "wget", "-O", "#{libexec}/lib/server/libjsig.dylib", libjsig_url

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
  end
end
