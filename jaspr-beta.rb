class JasprBeta < Formula
  desc "Stacked pull requests on GitHub"
  homepage "https://github.com/MichaelSims/git-jaspr"
  version "2.5.0-beta.2"
  license "Apache-2.0"
  conflicts_with "jaspr", because: "both install the jaspr binary"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/MichaelSims/git-jaspr/releases/download/v2.5.0-beta.2/jaspr-macos-arm64"
      sha256 "b90bcbe0f7d57d7b6d1c9998da8f5e5bc6348209dc4d71442d51322dd5c19717"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/MichaelSims/git-jaspr/releases/download/v2.5.0-beta.2/jaspr-linux-amd64"
      sha256 "9001325e567d9a643adce3b33e88458055adedfaf9d4a38561d06fb3933c1452"
    end
  end

  resource "bash_completion" do
    url "https://github.com/MichaelSims/git-jaspr/releases/download/v2.5.0-beta.2/jaspr.bash"
    sha256 "206f691ab32bdbe9973fc8cf19f0ddf7e2cd0dcb0f57a8a35088c85b463d2a3a"
  end

  resource "zsh_completion" do
    url "https://github.com/MichaelSims/git-jaspr/releases/download/v2.5.0-beta.2/_jaspr"
    sha256 "f87e88e6560a027e60619fcc23c43726c88b736fa6c353315e0ffd9de8d33661"
  end

  resource "fish_completion" do
    url "https://github.com/MichaelSims/git-jaspr/releases/download/v2.5.0-beta.2/jaspr.fish"
    sha256 "a815983714d9d307b3e9e5e0b69b511eb8569e24afeeb995e3af935bab1ad01a"
  end

  resource "man_page" do
    url "https://github.com/MichaelSims/git-jaspr/releases/download/v2.5.0-beta.2/jaspr.1"
    sha256 "71fbb2baf74541491342000f90da9b4c6a97d25c6d607fe47e178f9e0fec18e9"
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
