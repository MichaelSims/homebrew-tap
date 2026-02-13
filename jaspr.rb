class Jaspr < Formula
  desc "Stacked pull requests on GitHub"
  homepage "https://github.com/MichaelSims/git-jaspr"
  version "2.0-beta-4"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/MichaelSims/git-jaspr/releases/download/v2.0-beta-4/jaspr-macos-arm64"
      sha256 "19e7894a9b083e41c9b704721f56905ad870caf6f4a2c993aff3c752a75817ec"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/MichaelSims/git-jaspr/releases/download/v2.0-beta-4/jaspr-linux-amd64"
      sha256 "494225e619bbabfd8a808a074db07110ca5a24ff6a3de4b49062b54f83aa85a4"
    end
  end

  resource "bash_completion" do
    url "https://github.com/MichaelSims/git-jaspr/releases/download/v2.0-beta-4/jaspr.bash"
    sha256 "f221a169ec952d2e7e7eb1cf404c14af2e5c503b09d8dee784b53cf8e0c62cf0"
  end

  resource "zsh_completion" do
    url "https://github.com/MichaelSims/git-jaspr/releases/download/v2.0-beta-4/_jaspr"
    sha256 "27f654888231bf154555a72d507488d4f259589ede7b7aede1d32fada82d5ad5"
  end

  resource "fish_completion" do
    url "https://github.com/MichaelSims/git-jaspr/releases/download/v2.0-beta-4/jaspr.fish"
    sha256 "ddee979498c2726de32bd701af1d973f7d5b0dfbbb111122d97f3ceec9e02491"
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
  end

  test do
    system "#{bin}/jaspr", "--version"
  end
end
