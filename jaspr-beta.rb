class JasprBeta < Formula
  desc "Stacked pull requests on GitHub"
  homepage "https://github.com/MichaelSims/git-jaspr"
  version "2.1.0-beta.9"
  license "Apache-2.0"
  conflicts_with "jaspr", because: "both install the jaspr binary"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/MichaelSims/git-jaspr/releases/download/v2.1.0-beta.9/jaspr-macos-arm64"
      sha256 "e2e6cf453ea6a91bc45c09dbf3d96bd8fa674aefa075fb743cc99a238b2093a9"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/MichaelSims/git-jaspr/releases/download/v2.1.0-beta.9/jaspr-linux-amd64"
      sha256 "566ec5539dd25f74e61efe3a3968b4e8fd2a2f35fa5ecc20f7e92fd6be0565d7"
    end
  end

  resource "bash_completion" do
    url "https://github.com/MichaelSims/git-jaspr/releases/download/v2.1.0-beta.9/jaspr.bash"
    sha256 "9e0c00ae0c671e9051e9ab9924ca35d585a1735c0295c5dc62f60031c89cbadd"
  end

  resource "zsh_completion" do
    url "https://github.com/MichaelSims/git-jaspr/releases/download/v2.1.0-beta.9/_jaspr"
    sha256 "89e099bc9d385e3504689e98f42e6c31345db0e4f0decf74e88fc0540f2acad6"
  end

  resource "fish_completion" do
    url "https://github.com/MichaelSims/git-jaspr/releases/download/v2.1.0-beta.9/jaspr.fish"
    sha256 "b5868bb65aa93f7c9179792533168bf94747bd717414c611aa05c5bfb5c6dfc5"
  end

  resource "man_page" do
    url "https://github.com/MichaelSims/git-jaspr/releases/download/v2.1.0-beta.9/jaspr.1"
    sha256 "951b4c74d5fe23c6af54c6f2f6f06e6eb816af3f48d944eb7ac82d276dc94033"
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
