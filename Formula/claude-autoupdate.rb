# frozen_string_literal: true

# Homebrew formula for claude-autoupdate
class ClaudeAutoupdate < Formula
  desc "Automatic updates for claude-code Homebrew installations"
  homepage "https://github.com/dlgochan/claude-code-autoupdate"
  url "https://github.com/dlgochan/claude-code-autoupdate/archive/refs/tags/v1.0.1.tar.gz"
  sha256 "2c3a6b2053df607e4fbe721ad6a2f410e902fa0820814fee6acba00b1d893054"
  license "MIT"

  depends_on macos: :catalina

  def install
    # Install library files
    libexec.install "lib"

    # Install command with proper load path
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
      To enable auto-updates for claude-code:
        claude-autoupdate install

      Check status:
        claude-autoupdate status

      This tool is only for Homebrew installations of claude-code.
      Native installations already have built-in auto-updates.
    EOS
  end

  test do
    # Test that the command exists and shows help
    assert_match "Usage: brew claude-autoupdate", shell_output("#{bin}/claude-autoupdate")
  end
end
