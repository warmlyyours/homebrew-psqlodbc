require 'formula'

class Psqlodbc < Formula
  homepage 'http://psqlodbc.projects.pgfoundry.org/'
  url 'http://ftp.postgresql.org/pub/odbc/versions/src/psqlodbc-09.02.0100.tar.gz'
  sha1 '22338e86d13c213a4b771cc16f9210a51caa3a42'
  
  depends_on "postgresql"
  depends_on "unixodbc" => :optional
  depends_on "libiodbc" => [:optional, 'with-iodbc']

  def install
    args = ["--disable-dependency-tracking", "--prefix=#{prefix}", "--enable-pthreads"]
    args << "--with-libpq=#{Formula.factory('postgresql').lib}"
    
    if build.include? "disable-unicode"
      args << "--disable-unicode"
    end
    
    if build.include? "with-iodbc"
      args << "--with-iodbc=#{Formula.factory('libiodbc').prefix}"
    end
    if build.include? "with-unixodbc"
      args << "--with-unixodbc=#{Formula.factory('unixodbc').prefix}"
    end
    
    system "./configure", *args

    system "make"
    system "make", "install"
  end
end
