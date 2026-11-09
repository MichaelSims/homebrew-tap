class JasprBeta < Formula
  desc "Stacked pull requests on GitHub"
  homepage "https://github.com/MichaelSims/git-jaspr"
  version "2.5.0-beta.11"
  license "Apache-2.0"
  conflicts_with "jaspr", because: "both install the jaspr binary"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/MichaelSims/git-jaspr/releases/download/v2.5.0-beta.11/jaspr-macos-arm64"
      sha256 "2baa58a353daf26102b2e9307ef3184fbfdec13d10da39b7be8c69d1a96186cd"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/MichaelSims/git-jaspr/releases/download/v2.5.0-beta.11/jaspr-linux-amd64"
      sha256 "16d039c8b74589321af45f9fef7d90bd280c38cf147862d4ee291b25618406c6"
    end
  end

  resource "bash_completion" do
    url "https://github.com/MichaelSims/git-jaspr/releases/download/v2.5.0-beta.11/jaspr.bash"
    sha256 "9594d495d2082e032c7bf0085d156f7bb114e6e96a0676e683a6b9ba8c477189"
  end

  resource "zsh_completion" do
    url "https://github.com/MichaelSims/git-jaspr/releases/download/v2.5.0-beta.11/_jaspr"
    sha256 "3619afa80388b58e10e09352d38bdc0d45df873a95af8920b0e256e79f4692d1"
  end

  resource "fish_completion" do
    url "https://github.com/MichaelSims/git-jaspr/releases/download/v2.5.0-beta.11/jaspr.fish"
    sha256 "d2de94b8d9e8a27e98662e86379cf119f065fce1617d9dda460e1f8115998ead"
  end

  resource "man_page" do
    url "https://github.com/MichaelSims/git-jaspr/releases/download/v2.5.0-beta.11/jaspr.1"
    sha256 "c2c555649fba95502ee896b7560cf23a536cdfe116c528aab41f40737024ba4c"
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
