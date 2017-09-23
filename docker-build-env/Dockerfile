FROM debian:stretch
MAINTAINER ccondit@randomcoder.org

ADD assets /assets

RUN \
	echo "deb http://ftp.us.debian.org/debian stretch main non-free contrib" > /etc/apt/sources.list && \
	echo "deb http://security.debian.org/ stretch/updates main contrib non-free" >> /etc/apt/sources.list && \
	echo "deb http://ftp.us.debian.org/debian/ stretch-updates main non-free contrib" >> /etc/apt.sources.list && \
	apt-get update && \
	apt-get -y dist-upgrade && \
	apt-get -y install wget java-package libgl1-mesa-glx libgtk-3-0 libcairo-gobject2 libxslt1.1 libxtst6 libxxf86vm1 && \
	rm -rf /var/cache/apt && \
        cp -f /assets/oracle-jdk.sh /usr/share/java-package/ && \
	mkdir -p /download /packages

ENV \
	DOWNLOAD_URL=http://download.oracle.com/otn-pub/java/jdk/9+181/jdk-9_linux-x64_bin.tar.gz \
	PKG_NAME=jdk-9_linux-x64_bin.tar.gz \
	DIR_NAME=jdk-9

RUN \
	cd /download && \
	wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" "${DOWNLOAD_URL}" && \
	chown -R nobody:nogroup /packages && \
	chsh -s /bin/bash nobody && \
	cd /packages && \
	yes | su nobody fakeroot -- make-jpkg \
		--full-name 'Craig Condit' \
		--email 'ccondit@randomcoder.org' \
		--revision 1 \
		"/download/${PKG_NAME}" && \
	rm -rf /download

