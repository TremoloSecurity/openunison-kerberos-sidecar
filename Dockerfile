FROM ubuntu:20.04

ENV VERSION=Latest
ENV OS=Linux
ENV ARCH=x86_64

ADD reinit.sh /reinit.sh
ADD reinit-pwd.sh /reinit-pwd.sh

RUN apt-get update && \
    apt-get install -y ca-certificates krb5-user && \
    groupadd -r kerbuser -g 433 && \
    mkdir /usr/local/kerbuser && \
    useradd -u 431 -r -g kerbuser -d /usr/local/kerbuser -s /sbin/nologin -c "Kerberos image user" kerbuser && \
    chown kerbuser:kerbuser /reinit.sh && \
    chmod u+x /reinit.sh && \
    chown kerbuser:kerbuser /reinit-pwd.sh && \
    chmod u+x /reinit-pwd.sh

USER 431

CMD  /reinit.sh