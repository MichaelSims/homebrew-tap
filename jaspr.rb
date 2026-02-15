class Jaspr < Formula
  desc "Stacked pull requests on GitHub"
  homepage "https://github.com/MichaelSims/git-jaspr"
  version "2.0-beta-6"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/MichaelSims/git-jaspr/releases/download/v2.0-beta-6/jaspr-macos-arm64"
      sha256 "25ab3f8d9431a4041c2e977d6c26089b5aac653b28f25554550466ac98a02767"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/MichaelSims/git-jaspr/releases/download/v2.0-beta-6/jaspr-linux-amd64"
      sha256 "ba08b522165d104832441b82e8c48fc9e6d9d8529a14b42a8dc08fe0b8fbc8ce"
    end
  end

  resource "bash_completion" do
    url "https://github.com/MichaelSims/git-jaspr/releases/download/v2.0-beta-6/jaspr.bash"
    sha256 "67f46f9d6c3f6c8e1e8f4956b200a51c1db69bf681f74720fe10a30d3e5087f0"
  end

  resource "zsh_completion" do
    url "https://github.com/MichaelSims/git-jaspr/releases/download/v2.0-beta-6/_jaspr"
    sha256 "b977733f0d05bd67ddeaddc64ee013574cbfe20e6ea05b5fea79acfb02fa8377"
  end

  resource "fish_completion" do
    url "https://github.com/MichaelSims/git-jaspr/releases/download/v2.0-beta-6/jaspr.fish"
    sha256 "b67362e6484dea451ff72ee325adfe0e3c0cea91cf375b8a407539f3cc1bf470"
  end

  resource "man_page" do
    url "https://github.com/MichaelSims/git-jaspr/releases/download/v2.0-beta-6/jaspr.1"
    sha256 "59e53fdefaf421ba90b32df4c4f6a27d14ce68a7a4b94ebfc2022b3a27feb472"
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
