# typed: false
# frozen_string_literal: true

# This file was generated by GoReleaser. DO NOT EDIT.
class SprSims < Formula
  desc "Stacked Pull Requests on GitHub"
  homepage "https://github.com/MichaelSims/spr"
  version "1.0.0-sims"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/MichaelSims/spr/releases/download/v1.0.0-sims/spr_macos_x86_64.tar.gz"
      sha256 "59c4d567d149b23127d7c16f72a326a6adcc1c376c696ad880aa0d0358ea59c6"

      def install
        bin.install "git-spr"
        bin.install "git-amend"
        bin.install "spr_reword_helper"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/MichaelSims/spr/releases/download/v1.0.0-sims/spr_macos_arm64.tar.gz"
      sha256 "bccf447e974bb3dc962dd49fd936478f51f9d3a5e7d97587e5774a674c0225d4"

      def install
        bin.install "git-spr"
        bin.install "git-amend"
        bin.install "spr_reword_helper"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/MichaelSims/spr/releases/download/v1.0.0-sims/spr_linux_arm64.tar.gz"
      sha256 "2f76fdf673bd2a3452f616470ec667e147a3536702215529e7a4e2374ff6572a"

      def install
        bin.install "git-spr"
        bin.install "git-amend"
        bin.install "spr_reword_helper"
      end
    end
    if Hardware::CPU.intel?
      url "https://github.com/MichaelSims/spr/releases/download/v1.0.0-sims/spr_linux_x86_64.tar.gz"
      sha256 "e2d139c8e82a5e1c28b6b8637e9a4774362ebeecafc1e7b70441b026d194ca8c"

      def install
        bin.install "git-spr"
        bin.install "git-amend"
        bin.install "spr_reword_helper"
      end
    end
  end
end
