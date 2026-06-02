class Palace < Formula
  desc "Local-first memory retrieval engine for coding agents with MCP integration"
  homepage "https://github.com/AncientiCe/palace-rs"
  version "0.5.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/AncientiCe/palace-rs/releases/download/v0.5.0/palace-0.5.0-aarch64-apple-darwin.tar.gz"
      sha256 "9d983ac3cdcdae08fe0a576e89294233d215f6ec3fd6fe3876e6ba6a640b0fe8"
    end

    on_intel do
      odie "palace is not available for macOS Intel due to ONNX Runtime unavailability. Requires Apple Silicon."
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/AncientiCe/palace-rs/releases/download/v0.5.0/palace-0.5.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "98f8d71a2eaed80f3dc73be712deea5e3166eab2244feb3f20dc9da380ffb242"
    end
  end

  def install
    # Homebrew auto-extracts and may strip single top-level directory
    # Try direct install first
    if File.exist?("palace")
      bin.install "palace"
    else
      # Otherwise navigate into extracted directory
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
