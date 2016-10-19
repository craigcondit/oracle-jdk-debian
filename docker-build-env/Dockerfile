FROM debian:jessie
MAINTAINER ccondit@randomcoder.org

ENV \
	DOWNLOAD_URL=http://download.oracle.com/otn-pub/java/jdk/8u112-b15/jdk-8u112-linux-x64.tar.gz \
	PKG_NAME=jdk-8u112-linux-x64.tar.gz \
	DIR_NAME=jdk1.8.0_112

RUN \
	echo "deb http://ftp.us.debian.org/debian jessie main non-free contrib" > /etc/apt/sources.list && \
	echo "deb http://security.debian.org/ jessie/updates main contrib non-free" >> /etc/apt/sources.list && \
	echo "deb http://ftp.us.debian.org/debian/ jessie-updates main non-free contrib" >> /etc/apt.sources.list && \
	apt-get update && \
	apt-get -y dist-upgrade && \
	apt-get -y install wget java-package libgl1-mesa-glx libgtk2.0-0 libxslt1.1 libxtst6 libxxf86vm1 && \
	rm -rf /var/cache/apt && \
	mkdir -p /download /packages && \
	cd /download && \
	wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" "${DOWNLOAD_URL}" && \
	wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jce/8/jce_policy-8.zip && \
	tar zxf "${PKG_NAME}" && \
	rm -f "${PKG_NAME}" && \
	unzip jce_policy-8.zip && \
	rm -f jce_policy-8.zip && \
	cp -f UnlimitedJCEPolicyJDK8/*.jar "${DIR_NAME}"/jre/lib/security/ && \
	rm -rf UnlimitedJCEPolicyJDK8 && \
	chown -R root:root "${DIR_NAME}" && \
	tar zcf "${PKG_NAME}" "${DIR_NAME}" && \
	rm -rf "${DIR_NAME}" && \
	chown -R nobody:nogroup /packages && \
	chsh -s /bin/bash nobody && \
	cd /packages && \
	yes | su nobody fakeroot -- make-jpkg \
		--full-name 'Craig Condit' \
		--email 'ccondit@randomcoder.org' \
		--revision 1.ucrypto \
		"/download/${PKG_NAME}" && \
	rm -rf /download

