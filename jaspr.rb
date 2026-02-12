class Jaspr < Formula
  desc "Stacked pull requests on GitHub"
  homepage "https://github.com/MichaelSims/git-jaspr"
  version "2.0-beta-1"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/MichaelSims/git-jaspr/releases/download/v2.0-beta-1/jaspr-macos-arm64"
      sha256 "58d482df4298ba74377ead92861eedda2602750c93891e9edab8b298f8c3a62d"

      def install
        bin.install "jaspr-macos-arm64" => "jaspr"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/MichaelSims/git-jaspr/releases/download/v2.0-beta-1/jaspr-linux-amd64"
      sha256 "4c2e130e57218942d817e7d4174acbce991328d014e03cc09c20421bbc3df230"

      def install
        bin.install "jaspr-linux-amd64" => "jaspr"
      end
    end
  end

  test do
    system "#{bin}/jaspr", "--version"
  end
end
