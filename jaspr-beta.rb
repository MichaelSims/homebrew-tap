class JasprBeta < Formula
  desc "Stacked pull requests on GitHub"
  homepage "https://github.com/MichaelSims/git-jaspr"
  version "2.5.0-beta.12"
  license "Apache-2.0"
  conflicts_with "jaspr", because: "both install the jaspr binary"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/MichaelSims/git-jaspr/releases/download/v2.5.0-beta.12/jaspr-macos-arm64"
      sha256 "5eb9599a190e12c4c118d77222ffa950b44cb0481a0fc08a3dd8453d02a36816"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/MichaelSims/git-jaspr/releases/download/v2.5.0-beta.12/jaspr-linux-amd64"
      sha256 "04eb0a0a6f7c610b95c3d36e7d1e3c4702626926d12507090ef04863ebcef8f5"
    end
  end

  resource "bash_completion" do
    url "https://github.com/MichaelSims/git-jaspr/releases/download/v2.5.0-beta.12/jaspr.bash"
    sha256 "9594d495d2082e032c7bf0085d156f7bb114e6e96a0676e683a6b9ba8c477189"
  end

  resource "zsh_completion" do
    url "https://github.com/MichaelSims/git-jaspr/releases/download/v2.5.0-beta.12/_jaspr"
    sha256 "3619afa80388b58e10e09352d38bdc0d45df873a95af8920b0e256e79f4692d1"
  end

  resource "fish_completion" do
    url "https://github.com/MichaelSims/git-jaspr/releases/download/v2.5.0-beta.12/jaspr.fish"
    sha256 "1b5128a543061ed09c05f62291901bbef2d316124d01da3fc51a266685673078"
  end

  resource "man_page" do
    url "https://github.com/MichaelSims/git-jaspr/releases/download/v2.5.0-beta.12/jaspr.1"
    sha256 "8bd0b562b774ea5b069a1fb2c92616680f84a7c87c02ae9553f667fce61c7a5c"
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
