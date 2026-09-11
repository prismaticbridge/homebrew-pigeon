class Pigeon < Formula
  desc "The pigeon application"
  homepage "https://github.com/ArthurGuihaire/pigeon"
  version "0.4.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ArthurGuihaire/pigeon/releases/download/v0.4.1/pigeon-aarch64-apple-darwin.tar.xz"
      sha256 "b043a24a085601798be297aca144199c9d06b9bba4f9eff844ced39cad8b32c0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ArthurGuihaire/pigeon/releases/download/v0.4.1/pigeon-x86_64-apple-darwin.tar.xz"
      sha256 "dc55e88c8d0c1ee7c8d1c5aa2a9a72ccfc4f7976bfab94eff46941a5901a8666"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ArthurGuihaire/pigeon/releases/download/v0.4.1/pigeon-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "d23530bf1bd1af2abac2ddbd75044c4c291c6daf69851dabd4e65ceb8d403235"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ArthurGuihaire/pigeon/releases/download/v0.4.1/pigeon-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "85d82962fc813740d353076e3de5f42e81731e4dc39e84c4c5c400fc1681d0ec"
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
