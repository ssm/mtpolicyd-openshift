FROM debian:9

LABEL no.fnord.maintainer="Stig Sandbeck Mathisen <ssm@fnord.no>" \
      no.fnord.version="0.1.0" \
      io.openshift.expose-services="12345:tcp"

## Prepare for installation
RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get -y install mtpolicyd \
 && dpkg-statoverride --add --update root root 0770 /var/lib/mtpolicyd \
 && dpkg-statoverride --add --update root root 0770 /var/lib/mtpolicyd/mtpolicyd.sqlite \
 && apt-get clean

ADD mtpolicyd.conf /etc/mtpolicyd/mtpolicyd.conf

EXPOSE 12345

USER 1000
CMD /usr/bin/mtpolicyd -f
