class Htslib < Formula
  desc "C library for high-throughput sequencing data formats"
  homepage "http://www.htslib.org/"
  # tag "bioinformatics"

  url "https://github.com/samtools/htslib/archive/1.3.tar.gz"
  sha256 "291a54090df3bc367b509890e1cfa34d53b1ee9be42c5fa6c2b1e2ec8f8b13af"
  head "https://github.com/samtools/htslib.git"

  bottle do
    cellar :any
    revision 1
    sha256 "427abec04673b9e5ecad88fd4b4af7cc1a835926e7f05bc37f6b564cae59a7da" => :yosemite
    sha256 "857bf49037bc3caccaf295278e9d895e1b8a5cadf9aeaf1e841211d7d574b681" => :mavericks
    sha256 "4db40af2120ce5f02cf7377ec43e345659b26f1d735e906cac23f26b83ae67d3" => :mountain_lion
  end

  conflicts_with "tabix", :because => "both htslib and tabix install bin/tabix"

  def install
    system "make", "install", "prefix=#{prefix}"
    pkgshare.install "test"
  end

  test do
    sam = share/"htslib/test/ce#1.sam"
    assert_match "SAM", shell_output("htsfile #{sam}")
    system "bgzip -c #{sam} > sam.gz"
    assert File.exist?("sam.gz")
    system "tabix", "-p", "sam", "sam.gz"
    assert File.exist?("sam.gz.tbi")
  end
end
