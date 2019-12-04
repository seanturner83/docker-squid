FROM centos:7.2.1511
RUN yum install -y httpd-tools squid openssl ca-certificates && yum clean all
RUN update-ca-trust force-enable
ADD ca.crt /etc/pki/ca-trust/source/anchors/
RUN update-ca-trust
ADD squid.conf /etc/squid
RUN groupadd -g 892 cf && useradd -r -u 892 -g cf cf
RUN chown cf /usr/etc
EXPOSE 3128
USER cf
ADD init /init
CMD ["/init"]
