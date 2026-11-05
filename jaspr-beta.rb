class JasprBeta < Formula
  desc "Stacked pull requests on GitHub"
  homepage "https://github.com/MichaelSims/git-jaspr"
  version "2.5.0-beta.10"
  license "Apache-2.0"
  conflicts_with "jaspr", because: "both install the jaspr binary"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/MichaelSims/git-jaspr/releases/download/v2.5.0-beta.10/jaspr-macos-arm64"
      sha256 "673eecaab4b243ef7a5e75d9953f03444bfe774f667f249d2f78a8b58edf90ec"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/MichaelSims/git-jaspr/releases/download/v2.5.0-beta.10/jaspr-linux-amd64"
      sha256 "52e6a6082a83eaa86e6e3a608e6502e3fde4141c4e766c1ee56dd5b69248424e"
    end
  end

  resource "bash_completion" do
    url "https://github.com/MichaelSims/git-jaspr/releases/download/v2.5.0-beta.10/jaspr.bash"
    sha256 "1b646b3729207c11b1628350d207af84cbe841b2f0151c84ec92e8e8f9f1fd8f"
  end

  resource "zsh_completion" do
    url "https://github.com/MichaelSims/git-jaspr/releases/download/v2.5.0-beta.10/_jaspr"
    sha256 "c464a0780489b3475737086fce045274e6d54d8ad61b6a68fb82a48a84e045be"
  end

  resource "fish_completion" do
    url "https://github.com/MichaelSims/git-jaspr/releases/download/v2.5.0-beta.10/jaspr.fish"
    sha256 "b69679e60cec4cff47921074c2a960a4b361a042156ef3334f5c18e902a3ca51"
  end

  resource "man_page" do
    url "https://github.com/MichaelSims/git-jaspr/releases/download/v2.5.0-beta.10/jaspr.1"
    sha256 "212c85a2377625855caae88d12ebeebfd4fe1bcfe9240e97e36c918b668bf30a"
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
