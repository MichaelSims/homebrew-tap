class JasprBeta < Formula
  desc "Stacked pull requests on GitHub"
  homepage "https://github.com/MichaelSims/git-jaspr"
  version "2.1.0-beta.6"
  license "Apache-2.0"
  conflicts_with "jaspr", because: "both install the jaspr binary"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/MichaelSims/git-jaspr/releases/download/v2.1.0-beta.6/jaspr-macos-arm64"
      sha256 "305d173ee79bb0a0fb7ec9570953eb9f860b64b2b6a119804e2301f573e80557"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/MichaelSims/git-jaspr/releases/download/v2.1.0-beta.6/jaspr-linux-amd64"
      sha256 "700dd1d0e1a3f222d7afcfeddc28b84596e2541e5a325d375f555dd570bb1d67"
    end
  end

  resource "bash_completion" do
    url "https://github.com/MichaelSims/git-jaspr/releases/download/v2.1.0-beta.6/jaspr.bash"
    sha256 "b1021583c199afea83888c545085e7089df530041a7f4994ddf321219d88f5c8"
  end

  resource "zsh_completion" do
    url "https://github.com/MichaelSims/git-jaspr/releases/download/v2.1.0-beta.6/_jaspr"
    sha256 "cd3f2f6a84c5b848b7d57f05155f76df131bd4df2cf5c571d0fb192a67c51e80"
  end

  resource "fish_completion" do
    url "https://github.com/MichaelSims/git-jaspr/releases/download/v2.1.0-beta.6/jaspr.fish"
    sha256 "dbda0cb11281490b4b542e36354e4e91b679751af6bafb0f42236f8b907b2430"
  end

  resource "man_page" do
    url "https://github.com/MichaelSims/git-jaspr/releases/download/v2.1.0-beta.6/jaspr.1"
    sha256 "52a035df7a96d1ab468e85e5a1d60378dd3baa10fdbb9b58a2cc2e842729b876"
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
