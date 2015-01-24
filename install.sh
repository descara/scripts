#!/bin/bash

# Begin installing CIF dependencies
echo "Begin Installation"
yum -y install sudo bind-utils rng-tools postgresql-server httpd httpd-devel mod_ssl gcc make expat expat-devel uuid uuid-devel wget bind rsync libuuid-devel mod_perl mod_perl-devel ntpdate

# Update clock
echo "Synchronizing time"
ntpdate -u pool.ntp.org
echo "Downloading extra packages...."
yum -y install libapreq2-2 libapreq2-devel-2 perl-libapreq2-2 zeromq-2 zeromq-devel openpgm
echo "Installing perl modules...."
yum -y install perl-Digest-SHA libxml2 libxml2-devel perl-XML-LibXML perl-DBD-Pg perl-XML-RSS perl-JSON perl-Unicode-String perl-Config-Simple perl-Module-Pluggable perl-MIME-Lite perl-CPAN perl-Class-Accessor perl-YAML perl-XML-Parser uuid-perl perl-Net-DNS perl-DateTime-Format-DateParse perl-IO-Socket-INET6 openssl-devel perl-Module-Install perl-Net-SSLeay perl-Class-Trigger perl-Date-Manip perl-IO-Socket-SSL
echo "Test::More"
PERL_MM_USE_DEFAULT=1 perl -MCPAN -e 'install Test::More'

echo "Fetching version-0"
wget http://search.cpan.org/CPAN/authors/id/J/JP/JPEACOCK/version-0.9902.tar.gz
tar -zxvf version-0.9902.tar.gz
cd version-0.9902
echo "Installing version-0"
perl Makefile.PL && make && sudo make install

cpanm --self-upgrade
cpanm git://github.com/gitpan/Linux-Cpuinfo.git@1.7 --force
PERL_MM_USE_DEFAULT=1 perl -MCPAN -e 'install Module::Build,Test::SharedFork,Test::TCP,Net::Abuse::Utils,Linux::Cpuinfo,Google::ProtocolBuffers,Iodef::Pb::Simple,Compress::Snappy,Net::Abuse::Utils::Spamhaus,Net::DNS::Match,Snort::Rule,Parse::Range,Sys::MemInfo,JSON::XS,File::Type,LWP::UserAgent,Class::Trigger,Class::DBI,Net::Patricia,Text::Table,Mozilla::CA,IO::Socket::SSL,IO::Socket::INET6,LWP::Protocol::https,Text::CSV,XML::RSS,LWPx::ParanoidAgent,Log::Dispatch,ZeroMQ'
