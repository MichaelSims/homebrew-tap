class Jaspr < Formula
  desc "Stacked pull requests on GitHub"
  homepage "https://github.com/MichaelSims/git-jaspr"
  version "2.0-beta-5"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/MichaelSims/git-jaspr/releases/download/v2.0-beta-5/jaspr-macos-arm64"
      sha256 "6678853dda3a24407c9acd16c335bd94167d323a6641edfa1f7c094e49ab4480"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/MichaelSims/git-jaspr/releases/download/v2.0-beta-5/jaspr-linux-amd64"
      sha256 "3191a0518c06fef3a49b0000822cd9f60c9f4b637383924ebd19767148a16932"
    end
  end

  resource "bash_completion" do
    url "https://github.com/MichaelSims/git-jaspr/releases/download/v2.0-beta-5/jaspr.bash"
    sha256 "f221a169ec952d2e7e7eb1cf404c14af2e5c503b09d8dee784b53cf8e0c62cf0"
  end

  resource "zsh_completion" do
    url "https://github.com/MichaelSims/git-jaspr/releases/download/v2.0-beta-5/_jaspr"
    sha256 "27f654888231bf154555a72d507488d4f259589ede7b7aede1d32fada82d5ad5"
  end

  resource "fish_completion" do
    url "https://github.com/MichaelSims/git-jaspr/releases/download/v2.0-beta-5/jaspr.fish"
    sha256 "ddee979498c2726de32bd701af1d973f7d5b0dfbbb111122d97f3ceec9e02491"
  end

  resource "man_page" do
    url "https://github.com/MichaelSims/git-jaspr/releases/download/v2.0-beta-5/jaspr.1"
    sha256 "320219fdac71e530e5c483af6bce4ded28e09434b3f06afc0c69044b51b29099"
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
