class Jaspr < Formula
  desc "Stacked pull requests on GitHub"
  homepage "https://github.com/MichaelSims/git-jaspr"
  version "2.0.0"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/MichaelSims/git-jaspr/releases/download/v2.0.0/jaspr-macos-arm64"
      sha256 "1e700c8b44dea40a587b05941bc9fc4c6725d1561be8b09eaa13053b495e47a3"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/MichaelSims/git-jaspr/releases/download/v2.0.0/jaspr-linux-amd64"
      sha256 "ac7ec48e94a9d4654c297df75ab2219e6de2fb82432e0b6383986f995ab74fa7"
    end
  end

  resource "bash_completion" do
    url "https://github.com/MichaelSims/git-jaspr/releases/download/v2.0.0/jaspr.bash"
    sha256 "67f46f9d6c3f6c8e1e8f4956b200a51c1db69bf681f74720fe10a30d3e5087f0"
  end

  resource "zsh_completion" do
    url "https://github.com/MichaelSims/git-jaspr/releases/download/v2.0.0/_jaspr"
    sha256 "b977733f0d05bd67ddeaddc64ee013574cbfe20e6ea05b5fea79acfb02fa8377"
  end

  resource "fish_completion" do
    url "https://github.com/MichaelSims/git-jaspr/releases/download/v2.0.0/jaspr.fish"
    sha256 "b67362e6484dea451ff72ee325adfe0e3c0cea91cf375b8a407539f3cc1bf470"
  end

  resource "man_page" do
    url "https://github.com/MichaelSims/git-jaspr/releases/download/v2.0.0/jaspr.1"
    sha256 "49dc9f53cab53d74819715f25cafde4da956a10f3e15c57980939191736ac4ff"
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
