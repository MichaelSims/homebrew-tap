class JasprBeta < Formula
  desc "Stacked pull requests on GitHub"
  homepage "https://github.com/MichaelSims/git-jaspr"
  version "2.5.0-beta.4"
  license "Apache-2.0"
  conflicts_with "jaspr", because: "both install the jaspr binary"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/MichaelSims/git-jaspr/releases/download/v2.5.0-beta.4/jaspr-macos-arm64"
      sha256 "21fde07ba554587ef12b0c148615258dd273a86c4703fb0d56c597ca74447db0"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/MichaelSims/git-jaspr/releases/download/v2.5.0-beta.4/jaspr-linux-amd64"
      sha256 "9c57f7ccf85fc041c4d848f55b391f3532b4047b89cf1afc9a5bc2075a176274"
    end
  end

  resource "bash_completion" do
    url "https://github.com/MichaelSims/git-jaspr/releases/download/v2.5.0-beta.4/jaspr.bash"
    sha256 "206f691ab32bdbe9973fc8cf19f0ddf7e2cd0dcb0f57a8a35088c85b463d2a3a"
  end

  resource "zsh_completion" do
    url "https://github.com/MichaelSims/git-jaspr/releases/download/v2.5.0-beta.4/_jaspr"
    sha256 "f87e88e6560a027e60619fcc23c43726c88b736fa6c353315e0ffd9de8d33661"
  end

  resource "fish_completion" do
    url "https://github.com/MichaelSims/git-jaspr/releases/download/v2.5.0-beta.4/jaspr.fish"
    sha256 "a815983714d9d307b3e9e5e0b69b511eb8569e24afeeb995e3af935bab1ad01a"
  end

  resource "man_page" do
    url "https://github.com/MichaelSims/git-jaspr/releases/download/v2.5.0-beta.4/jaspr.1"
    sha256 "89da38e7c334ced453e666f267cfd4f1a3992ca9a54a749d2bf3c7f567090593"
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
