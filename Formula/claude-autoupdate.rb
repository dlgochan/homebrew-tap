# frozen_string_literal: true

# Homebrew formula for claude-autoupdate
class ClaudeAutoupdate < Formula
  desc "Automatic updates for claude-code Homebrew installations"
  homepage "https://github.com/dlgochan/claude-code-autoupdate"
  url "https://github.com/dlgochan/claude-code-autoupdate/archive/refs/tags/v1.1.1.tar.gz"
  sha256 "f2437c2db6a860b6ec6325d680e3614473314e0778c58a311fd9dcacc6242609"
  license "MIT"

  depends_on macos: :catalina

  def install
    # Install library files
    libexec.install "lib"

    # Install command
    (bin/"claude-autoupdate").write <<~RUBY
      #!/usr/bin/env ruby
      # frozen_string_literal: true

      $LOAD_PATH.unshift("#{libexec}/lib")
      load "#{libexec}/cmd/claude-autoupdate.rb"
    RUBY

    # Copy command file to libexec
    libexec.install "cmd"
  end

  def caveats
    <<~EOS
      Enable auto-updates for claude-code:
        claude-autoupdate enable

      This tool is only for Homebrew installations of claude-code.
      Native installations already have built-in auto-updates.

      Commands:
        claude-autoupdate enable     # Enable auto-updates
        claude-autoupdate status     # Check status
        claude-autoupdate update     # Update now
        claude-autoupdate disable    # Disable
    EOS
  end

  test do
    # Test that the command exists and shows help
    assert_match "Usage: claude-autoupdate", shell_output("#{bin}/claude-autoupdate")
  end
end
