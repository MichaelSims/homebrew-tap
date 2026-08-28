class JasprBeta < Formula
  desc "Stacked pull requests on GitHub"
  homepage "https://github.com/MichaelSims/git-jaspr"
  version "27-beta"
  license "Apache-2.0"
  conflicts_with "jaspr", because: "both install the jaspr binary"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/MichaelSims/git-jaspr/releases/download/v27-beta/jaspr-macos-arm64"
      sha256 "93cdb10fe5530b33b3d8db6173a81a74c4cb515a60d5f66a40338d2974504a17"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/MichaelSims/git-jaspr/releases/download/v27-beta/jaspr-linux-amd64"
      sha256 "21f0f60e1bf447aa2c62afbb514a4ff49b3f73ca4b50ad1f9a9af4a5ae75607c"
    end
  end

  resource "bash_completion" do
    url "https://github.com/MichaelSims/git-jaspr/releases/download/v27-beta/jaspr.bash"
    sha256 "206f691ab32bdbe9973fc8cf19f0ddf7e2cd0dcb0f57a8a35088c85b463d2a3a"
  end

  resource "zsh_completion" do
    url "https://github.com/MichaelSims/git-jaspr/releases/download/v27-beta/_jaspr"
    sha256 "f87e88e6560a027e60619fcc23c43726c88b736fa6c353315e0ffd9de8d33661"
  end

  resource "fish_completion" do
    url "https://github.com/MichaelSims/git-jaspr/releases/download/v27-beta/jaspr.fish"
    sha256 "a815983714d9d307b3e9e5e0b69b511eb8569e24afeeb995e3af935bab1ad01a"
  end

  resource "man_page" do
    url "https://github.com/MichaelSims/git-jaspr/releases/download/v27-beta/jaspr.1"
    sha256 "e1b57f3da56a610ad775a63447b713a3e8e7aecfea824596f60d7b3d8753e59f"
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
