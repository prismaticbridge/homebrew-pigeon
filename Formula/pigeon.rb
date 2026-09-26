class Pigeon < Formula
  desc "The pigeon application"
  homepage "https://github.com/ArthurGuihaire/pigeon"
  version "0.4.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ArthurGuihaire/pigeon/releases/download/v0.4.4/pigeon-aarch64-apple-darwin.tar.xz"
      sha256 "acc24df583830957b9ee7c0e9b6f0745b23556b7b6a3619033ab12995e6b07ed"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ArthurGuihaire/pigeon/releases/download/v0.4.4/pigeon-x86_64-apple-darwin.tar.xz"
      sha256 "a4e1100d0957b5e4862922a68ed547ac1d7bbb1299317b9a1a07ffb7d9dbec73"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ArthurGuihaire/pigeon/releases/download/v0.4.4/pigeon-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "4eb6cd82ef30e0ea0969102f8b489590d52f5a93fd8be65088334831ee8d9b3f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ArthurGuihaire/pigeon/releases/download/v0.4.4/pigeon-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "0fcee36dc566e53096c67cbaac73fd75cbbe99d8b58331759a4ce9d3b760bbca"
    end
  end

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "pigeon", "server"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "pigeon", "server"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "pigeon", "server"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "pigeon", "server"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
