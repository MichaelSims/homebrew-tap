class JasprBeta < Formula
  desc "Stacked pull requests on GitHub"
  homepage "https://github.com/MichaelSims/git-jaspr"
  version "2.1.0-beta.8"
  license "Apache-2.0"
  conflicts_with "jaspr", because: "both install the jaspr binary"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/MichaelSims/git-jaspr/releases/download/v2.1.0-beta.8/jaspr-macos-arm64"
      sha256 "b50e18fc18536f00b8811fd53def159962f26dfff1df5e0a57bec8c6a7393011"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/MichaelSims/git-jaspr/releases/download/v2.1.0-beta.8/jaspr-linux-amd64"
      sha256 "fbd899c80b209dd02e5eaa484825ca61fa8909e3feab853ee2fd081720ff2625"
    end
  end

  resource "bash_completion" do
    url "https://github.com/MichaelSims/git-jaspr/releases/download/v2.1.0-beta.8/jaspr.bash"
    sha256 "9e0c00ae0c671e9051e9ab9924ca35d585a1735c0295c5dc62f60031c89cbadd"
  end

  resource "zsh_completion" do
    url "https://github.com/MichaelSims/git-jaspr/releases/download/v2.1.0-beta.8/_jaspr"
    sha256 "89e099bc9d385e3504689e98f42e6c31345db0e4f0decf74e88fc0540f2acad6"
  end

  resource "fish_completion" do
    url "https://github.com/MichaelSims/git-jaspr/releases/download/v2.1.0-beta.8/jaspr.fish"
    sha256 "8e03ce351474ead635dc206f6b9ef270893e2ae9ac12e96ca79065159383c14f"
  end

  resource "man_page" do
    url "https://github.com/MichaelSims/git-jaspr/releases/download/v2.1.0-beta.8/jaspr.1"
    sha256 "c1774bd9b52670b81e7836342be1d1786ba98b338d4a028c35448216ca043ba1"
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
