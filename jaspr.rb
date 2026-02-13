class Jaspr < Formula
  desc "Stacked pull requests on GitHub"
  homepage "https://github.com/MichaelSims/git-jaspr"
  version "2.0-beta-2"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/MichaelSims/git-jaspr/releases/download/v2.0-beta-2/jaspr-macos-arm64"
      sha256 "24c2833f3fba8521c25979c0496e707483192eaa173273228132c9547bdbacf6"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/MichaelSims/git-jaspr/releases/download/v2.0-beta-2/jaspr-linux-amd64"
      sha256 "df8e9653227ee80d729184cab04f62fffe0fe80537c11aa999e3bea5000fc9bf"
    end
  end

  resource "bash_completion" do
    url "https://github.com/MichaelSims/git-jaspr/releases/download/v2.0-beta-2/jaspr.bash"
    sha256 "211335dcef1f8a20392222684389f4e3502af8234861526b0024ba34225bf4a2"
  end

  resource "zsh_completion" do
    url "https://github.com/MichaelSims/git-jaspr/releases/download/v2.0-beta-2/_jaspr"
    sha256 "62fd4e24576b5cead24f08c9ff5c24d7ad5c33e64b899aaed10e81dc9a6d5ca7"
  end

  resource "fish_completion" do
    url "https://github.com/MichaelSims/git-jaspr/releases/download/v2.0-beta-2/jaspr.fish"
    sha256 "9cf536e92a9572d538ddbf0e64a0cd43e09e01a053eeda5337ad4798de555496"
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "jaspr-macos-arm64" => "jaspr"
    elsif OS.linux? && Hardware::CPU.intel?
      bin.install "jaspr-linux-amd64" => "jaspr"
    end

    resource("bash_completion").stage do
      bash_completion.install "jaspr.bash" => "jaspr"
    end
    resource("zsh_completion").stage do
      zsh_completion.install "_jaspr"
    end
    resource("fish_completion").stage do
      fish_completion.install "jaspr.fish" => "jaspr.fish"
    end
  end

  test do
    system "#{bin}/jaspr", "--version"
  end
end
