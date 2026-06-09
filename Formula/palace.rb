class Palace < Formula
  desc "Local-first memory retrieval engine for coding agents with MCP integration"
  homepage "https://github.com/AncientiCe/palace-rs"
  version "0.6.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/AncientiCe/palace-rs/releases/download/v0.6.0/palace-0.6.0-aarch64-apple-darwin.tar.gz"
      sha256 "d59c2bad4a34ed6ce5b13280d640dbfe64b02bfd2b8407e19eb4435a2dbd23b3"
    end

    on_intel do
      odie "palace is not available for macOS Intel due to ONNX Runtime unavailability. Requires Apple Silicon."
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/AncientiCe/palace-rs/releases/download/v0.6.0/palace-0.6.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "c4776a895179ff6b7b87e9ecc9d270f0a8059d368ee3e8a5dc6d840bf2df2a6b"
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
