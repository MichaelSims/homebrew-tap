class JasprBeta < Formula
  desc "Stacked pull requests on GitHub"
  homepage "https://github.com/MichaelSims/git-jaspr"
  version "2.3.0-beta.1"
  license "Apache-2.0"
  conflicts_with "jaspr", because: "both install the jaspr binary"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/MichaelSims/git-jaspr/releases/download/v2.3.0-beta.1/jaspr-macos-arm64"
      sha256 "326c5918e4f93b73d5d52952e99c7d37f50a5dc2501c35337ef9c99d015771fa"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/MichaelSims/git-jaspr/releases/download/v2.3.0-beta.1/jaspr-linux-amd64"
      sha256 "6e4295573d93e4df5dede8acc65a2b0e05e67d3dea487a9fe7f3b9b3bfc2591a"
    end
  end

  resource "bash_completion" do
    url "https://github.com/MichaelSims/git-jaspr/releases/download/v2.3.0-beta.1/jaspr.bash"
    sha256 "18b2a66f54cd2e25a6d9d98ddaf0bae8b0d66805fb3e106c6a74399a1d3ff993"
  end

  resource "zsh_completion" do
    url "https://github.com/MichaelSims/git-jaspr/releases/download/v2.3.0-beta.1/_jaspr"
    sha256 "31fc222a68cdc03c8868dbf38f1effa8252a3863268214d805c7aa0f89f3ad81"
  end

  resource "fish_completion" do
    url "https://github.com/MichaelSims/git-jaspr/releases/download/v2.3.0-beta.1/jaspr.fish"
    sha256 "0a2779e7158289bfae94c1c1247ea7d22460051113ef753e2d86a5610a38d7eb"
  end

  resource "man_page" do
    url "https://github.com/MichaelSims/git-jaspr/releases/download/v2.3.0-beta.1/jaspr.1"
    sha256 "c65cd1afd63830f77b534bd76b94f4321c8f80baf2a5b90b2c262ed987afa00d"
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
