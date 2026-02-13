class Jaspr < Formula
  desc "Stacked pull requests on GitHub"
  homepage "https://github.com/MichaelSims/git-jaspr"
  version "2.0-beta-3"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/MichaelSims/git-jaspr/releases/download/v2.0-beta-3/jaspr-macos-arm64"
      sha256 "7d67d825a94e8f0c451151b6cd39d88150f2415c6df70874b21c605361ba3788"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/MichaelSims/git-jaspr/releases/download/v2.0-beta-3/jaspr-linux-amd64"
      sha256 "5f85c1a35f3a037502a5978d8bfe0e5dfae7c13681c3ab87a664aadb1176197b"
    end
  end

  resource "bash_completion" do
    url "https://github.com/MichaelSims/git-jaspr/releases/download/v2.0-beta-3/jaspr.bash"
    sha256 "e3805ff4e7b3d073e2a2a8c55d38a9e44e00a2a168c09fc2d4c596b84c72c49e"
  end

  resource "zsh_completion" do
    url "https://github.com/MichaelSims/git-jaspr/releases/download/v2.0-beta-3/_jaspr"
    sha256 "60ebf500d76e2159b917f193bdba11d95841e6e488294692b0e61ac0a061c03c"
  end

  resource "fish_completion" do
    url "https://github.com/MichaelSims/git-jaspr/releases/download/v2.0-beta-3/jaspr.fish"
    sha256 "04c14ba012ed8efcbcc3e7ea0a4a694a5ea49c093e4afdd8ec5d24d883b76b38"
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
