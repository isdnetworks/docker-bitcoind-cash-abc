FROM isdnetworks/centos:8-ko
LABEL maintainer="is:-D Networks Docker Maintainers <jhcheong@isdnetworks.pe.kr>"

ADD bitcoin-abc-0.22.12-x86_64-linux-gnu.tar.gz /usr/local/
WORKDIR /usr/local/bitcoin-abc-0.22.12
RUN chown -R 0:0 . \
 && cp bin/* /usr/bin \
 && cp include/* /usr/include \
 && cp lib/libbitcoinconsensus.so.0.22.12 /usr/lib64 \
 && ln -s libbitcoinconsensus.so.0.22.12 /usr/lib64/libbitcoinconsensus.so.0 \
 && ln -s libbitcoinconsensus.so.0 /usr/lib64/libbitcoinconsensus.so \
 && ldconfig \
 && cd .. \
 && rm -rf bitcoin-abc-0.22.12 \
 && useradd -m -s /bin/bash -u 1000 bitcoin

WORKDIR /home/bitcoin
USER bitcoin
RUN mkdir .bitcoin \
 && chmod 700 .bitcoin

VOLUME ["/home/bitcoin/.bitcoin"]

EXPOSE 8333/tcp 8333/udp 8332/tcp 18333/tcp 18333/udp 18332/tcp 18444/tcp 18444/udp 18443/tcp

CMD ["bitcoind", "-printtoconsole", "-debuglogfile=0"]

