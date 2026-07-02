class Palace < Formula
  desc "Local-first memory retrieval engine for coding agents with MCP integration"
  homepage "https://github.com/AncientiCe/palace-rs"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/AncientiCe/palace-rs/releases/download/v0.9.1/palace-0.9.1-aarch64-apple-darwin.tar.gz"
      sha256 "1e3026cc713d7dd6b17fb9e2050f15696abe483cc14bb01ba51a1d93ecfbf628"
    end

    on_intel do
      odie "palace is not available for macOS Intel due to ONNX Runtime unavailability. Requires Apple Silicon."
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/AncientiCe/palace-rs/releases/download/v0.9.1/palace-0.9.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "e7543791a6c25f90c2b89eccafcf9a409b50987170764d8f79d2a63086528569"
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
