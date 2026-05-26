class Palace < Formula
  desc "Local-first memory retrieval engine for coding agents with MCP integration"
  homepage "https://github.com/AncientiCe/palace-rs"
  version "0.4.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/AncientiCe/palace-rs/releases/download/v0.4.0/palace-0.4.0-aarch64-apple-darwin.tar.gz"
      sha256 "725a35c1f4a0bbff4ec24aee9d8a3aed0f762873ca017846a0217faf778b74c9"
    end

    on_intel do
      odie "palace is not available for macOS Intel due to ONNX Runtime unavailability. Requires Apple Silicon."
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/AncientiCe/palace-rs/releases/download/v0.4.0/palace-0.4.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "8fc1a4180056ff256a9a6a73042c4caa674908c0f1d9395c620b9e7d0a86c1ac"
    end
  end

  def install
    # Extract binary from nested directory structure
    # Archives contain: palace-0.4.0-{target}/palace
    bin.install Dir["palace-*/palace"].first => "palace"

    # Install documentation
    doc.install Dir["palace-*/README.md"].first if Dir["palace-*/README.md"].any?
    doc.install Dir["palace-*/CHANGELOG.md"].first if Dir["palace-*/CHANGELOG.md"].any?
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
