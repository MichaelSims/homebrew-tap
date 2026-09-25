class JasprBeta < Formula
  desc "Stacked pull requests on GitHub"
  homepage "https://github.com/MichaelSims/git-jaspr"
  version "2.5.0-beta.9"
  license "Apache-2.0"
  conflicts_with "jaspr", because: "both install the jaspr binary"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/MichaelSims/git-jaspr/releases/download/v2.5.0-beta.9/jaspr-macos-arm64"
      sha256 "9a23b1bf69f672afb1ae9a316696149a2bcd344a3b79f3c823190dbf6010acac"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/MichaelSims/git-jaspr/releases/download/v2.5.0-beta.9/jaspr-linux-amd64"
      sha256 "6227e21f8b3431740a98cab01768e80af5928689b96e8eb0b2f33b8ae2129bf5"
    end
  end

  resource "bash_completion" do
    url "https://github.com/MichaelSims/git-jaspr/releases/download/v2.5.0-beta.9/jaspr.bash"
    sha256 "18b2a66f54cd2e25a6d9d98ddaf0bae8b0d66805fb3e106c6a74399a1d3ff993"
  end

  resource "zsh_completion" do
    url "https://github.com/MichaelSims/git-jaspr/releases/download/v2.5.0-beta.9/_jaspr"
    sha256 "31fc222a68cdc03c8868dbf38f1effa8252a3863268214d805c7aa0f89f3ad81"
  end

  resource "fish_completion" do
    url "https://github.com/MichaelSims/git-jaspr/releases/download/v2.5.0-beta.9/jaspr.fish"
    sha256 "0a2779e7158289bfae94c1c1247ea7d22460051113ef753e2d86a5610a38d7eb"
  end

  resource "man_page" do
    url "https://github.com/MichaelSims/git-jaspr/releases/download/v2.5.0-beta.9/jaspr.1"
    sha256 "96a4acef8ecdc63343336b10fb5803f44a1ee7f778fba4d295b686e6215dd889"
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "jaspr-macos-arm64" => "jaspr"
    elsif OS.linux? && Hardware::CPU.intel?
      bin.install "jaspr-linux-amd64" => "jaspr"
    end

    # Create a symlink for backward compatibility with the old name "git-jaspr"
    bin.install_symlink "jaspr" => "git-jaspr"

    resource("bash_completion").stage do
      bash_completion.install "jaspr.bash" => "jaspr"
    end
    resource("zsh_completion").stage do
      zsh_completion.install "_jaspr"
    end
    resource("fish_completion").stage do
      fish_completion.install "jaspr.fish" => "jaspr.fish"
    end
    resource("man_page").stage do
      man1.install "jaspr.1"
    end
  end

  test do
    system "#{bin}/jaspr", "--version"
  end
end
