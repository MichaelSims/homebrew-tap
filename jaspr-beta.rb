class JasprBeta < Formula
  desc "Stacked pull requests on GitHub"
  homepage "https://github.com/MichaelSims/git-jaspr"
  version "2.1.1-beta.1"
  license "Apache-2.0"
  conflicts_with "jaspr", because: "both install the jaspr binary"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/MichaelSims/git-jaspr/releases/download/v2.1.1-beta.1/jaspr-macos-arm64"
      sha256 "1a3171a0ddfb4fe5af571cde199857d97317a95af9e0aab5e49b7c03422bb12a"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/MichaelSims/git-jaspr/releases/download/v2.1.1-beta.1/jaspr-linux-amd64"
      sha256 "e5755c87fac7fe133d5b396a1b952cadb93a9a2f2a36c9f1c1e4140ff582f61f"
    end
  end

  resource "bash_completion" do
    url "https://github.com/MichaelSims/git-jaspr/releases/download/v2.1.1-beta.1/jaspr.bash"
    sha256 "9e0c00ae0c671e9051e9ab9924ca35d585a1735c0295c5dc62f60031c89cbadd"
  end

  resource "zsh_completion" do
    url "https://github.com/MichaelSims/git-jaspr/releases/download/v2.1.1-beta.1/_jaspr"
    sha256 "89e099bc9d385e3504689e98f42e6c31345db0e4f0decf74e88fc0540f2acad6"
  end

  resource "fish_completion" do
    url "https://github.com/MichaelSims/git-jaspr/releases/download/v2.1.1-beta.1/jaspr.fish"
    sha256 "9a1a44e5e83ed3b402815f7d37ac3ac8f7638467148a9ec8afdb3066b1cd6d36"
  end

  resource "man_page" do
    url "https://github.com/MichaelSims/git-jaspr/releases/download/v2.1.1-beta.1/jaspr.1"
    sha256 "dba6457c14ce374da62252f955f8a0224c6dffae9f9c1a615c80dd24013ceb63"
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
