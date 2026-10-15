class Palace < Formula
  desc "Local-first memory retrieval engine for coding agents with MCP integration"
  homepage "https://github.com/AncientiCe/palace-rs"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/AncientiCe/palace-rs/releases/download/v0.17.0/palace-0.17.0-aarch64-apple-darwin.tar.gz"
      sha256 "505d7a4421b6477298deb1bcd6005e7e25c3f70a997431431aeae80df2013fd2"
    end

    on_intel do
      odie "palace is not available for macOS Intel due to ONNX Runtime unavailability. Requires Apple Silicon."
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/AncientiCe/palace-rs/releases/download/v0.17.0/palace-0.17.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "e276c5b9e14c3b0bd543d81233ad41e94e7d713ed8d42a38b76838494e142ef2"
    end
  end

  def install
    # Homebrew auto-extracts and may strip single top-level directory.
    if File.exist?("palace")
      bin.install "palace"
    else
      cd Dir["palace-*"].first do
        bin.install "palace"
      end
    end
  end

  def caveats
    <<~EOS
      Palace has been installed successfully.

      To configure MCP servers for your coding environment:
        palace install --all

      This will set up Palace for Cursor, Codex, Claude Code, and Claude Desktop.

      First-time usage will download the embedding model (~80MB) to ~/.palace/onnx_cache

      Next steps:
        palace init <project>
        palace mine <project>

      Restart your coding environment to load the MCP server.

      For more information: https://github.com/AncientiCe/palace-rs
    EOS
  end

  test do
    assert_match "palace #{version}", shell_output("#{bin}/palace --version")
    system bin/"palace", "status"
  end
end
