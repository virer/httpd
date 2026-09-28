FROM quay.io/fedora/fedora-minimal

RUN dnf install httpd -y
RUN sed -i 's/Listen 80/Listen 8080/g;s/User apache//g;s/Group apache//g' /etc/httpd/conf/httpd.conf && \
	echo "ServerName localhost" >> /etc/httpd/conf/httpd.conf 

RUN ln -sf /dev/stdout /var/log/httpd/access_log && \
    ln -sf /dev/stderr /var/log/httpd/error_log

RUN chgrp -R 0 /etc/httpd /var/log/httpd /tmp /run && \
    chown apache /run/httpd /var/log/httpd /tmp /run && \
    chmod -R g+rwX /run/httpd /var/log/httpd /tmp /run 

EXPOSE 8080
ENV LANG=C

USER apache
CMD ["/usr/sbin/httpd", "-DFOREGROUND"]

