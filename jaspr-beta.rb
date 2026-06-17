class JasprBeta < Formula
  desc "Stacked pull requests on GitHub"
  homepage "https://github.com/MichaelSims/git-jaspr"
  version "2.1.0-beta.10"
  license "Apache-2.0"
  conflicts_with "jaspr", because: "both install the jaspr binary"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/MichaelSims/git-jaspr/releases/download/v2.1.0-beta.10/jaspr-macos-arm64"
      sha256 "9321463dfeb068c703d478e3260469c45cf273899aedb1f41cf3773895c40940"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/MichaelSims/git-jaspr/releases/download/v2.1.0-beta.10/jaspr-linux-amd64"
      sha256 "a8a48241ee438c7890ddef2bf0f8368a55252f87152fd904c87ad91e4f4a4cb4"
    end
  end

  resource "bash_completion" do
    url "https://github.com/MichaelSims/git-jaspr/releases/download/v2.1.0-beta.10/jaspr.bash"
    sha256 "9e0c00ae0c671e9051e9ab9924ca35d585a1735c0295c5dc62f60031c89cbadd"
  end

  resource "zsh_completion" do
    url "https://github.com/MichaelSims/git-jaspr/releases/download/v2.1.0-beta.10/_jaspr"
    sha256 "89e099bc9d385e3504689e98f42e6c31345db0e4f0decf74e88fc0540f2acad6"
  end

  resource "fish_completion" do
    url "https://github.com/MichaelSims/git-jaspr/releases/download/v2.1.0-beta.10/jaspr.fish"
    sha256 "9a1a44e5e83ed3b402815f7d37ac3ac8f7638467148a9ec8afdb3066b1cd6d36"
  end

  resource "man_page" do
    url "https://github.com/MichaelSims/git-jaspr/releases/download/v2.1.0-beta.10/jaspr.1"
    sha256 "2f8906f7209a47efa98b2814c595ffb70a843ed0e4dfd3f9967a7d64e52a2471"
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
