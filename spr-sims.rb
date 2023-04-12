# typed: false
# frozen_string_literal: true

# This file was generated by GoReleaser. DO NOT EDIT.
class SprSims < Formula
  desc "Stacked Pull Requests on GitHub"
  homepage "https://github.com/MichaelSims/spr"
  version "1.0.0-sims"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/MichaelSims/spr/releases/download/v1.0.0-sims/spr_macos_arm64.tar.gz"
      sha256 "a59f32b474146b9bb4637b88d788a17c38a0b2336c64d7d436845ae88ca84d72"

      def install
        bin.install "git-spr"
        bin.install "git-amend"
        bin.install "spr_reword_helper"
      end
    end
    if Hardware::CPU.intel?
      url "https://github.com/MichaelSims/spr/releases/download/v1.0.0-sims/spr_macos_x86_64.tar.gz"
      sha256 "02b22b22ace3b4bd22d8251cff6015f5f7bb73cb6a78db2533199cb805965d60"

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
      sha256 "fadd8aaee9ec689e3bc03487d8451efa5d108392fba4b9c3ee37da82972c33b5"

      def install
        bin.install "git-spr"
        bin.install "git-amend"
        bin.install "spr_reword_helper"
      end
    end
    if Hardware::CPU.intel?
      url "https://github.com/MichaelSims/spr/releases/download/v1.0.0-sims/spr_linux_x86_64.tar.gz"
      sha256 "fed64de6b45fc893fbcb43eb3ed19a54e7724e46cdd74f46fae6f15b3750f0e2"

      def install
        bin.install "git-spr"
        bin.install "git-amend"
        bin.install "spr_reword_helper"
      end
    end
  end
end
