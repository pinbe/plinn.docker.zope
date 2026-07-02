FROM python:2.7
LABEL maintener="Benoît Pin <benoit.pin@gmail.com>"

ENV ZOPE_HOME=/opt/zope \
    S6_OVERLAY_VERSION=3.2.3.0

ADD https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-noarch.tar.xz /tmp
RUN tar -C / -Jxpf /tmp/s6-overlay-noarch.tar.xz
ADD https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-x86_64.tar.xz /tmp
RUN tar -C / -Jxpf /tmp/s6-overlay-x86_64.tar.xz

# Debian
RUN mkdir -p $ZOPE_HOME/var &&  \
    groupadd -g 500 zope-www && \
    useradd  -g 500 -u 500 -m -s /bin/bash zope-www && \
    chown -R 500:500 $ZOPE_HOME && \
    sed -i s/deb.debian.org/archive.debian.org/g /etc/apt/sources.list && \
    sed -i 's|security.debian.org|archive.debian.org/|g' /etc/apt/sources.list && \
    sed -i '/buster-updates/d' /etc/apt/sources.list && \
    apt-get update && \
    apt-get install -y exempi libexempi-dev libjpeg-progs

# libxml2
RUN wget "https://download.gnome.org/sources/libxml2/2.9/libxml2-2.9.9.tar.xz" && \
    tar xf libxml2-2.9.9.tar.xz && \
    cd libxml2-2.9.9 && \
    ./configure --with-python="/usr/local/bin/python" && \
    make && \
    make install && \
    sed -i 's/encoding = "ascii"/encoding = "utf-8"/' /usr/local/lib/python2.7/site.py

# pip
COPY src/zope-2.13.22-plinn-deps-installed.txt /

RUN pip install -r zope-2.13.22-plinn-deps-installed.txt && \
    pip install Products.ExtendedPathIndex==3.4.2 && \
    pip install Pillow==6.2.2

# Plinn zope products
WORKDIR $ZOPE_HOME/src
RUN wget https://github.com/pinbe/Plinn/releases/download/v0.9.2/build.tar.xz && \
    tar xJf build.tar.xz && \
    pip install -e Plinn && \
    rm -rf build.tar.xz && \
    git clone -b ckeditor4.14 https://github.com/pinbe/ckeditor.git && \
    pip install -e ckeditor && \
    git clone -b master-egg https://github.com/pinbe/Epoz.git && \
    pip install -e Epoz && \
    git clone -b zope-2.13-egg https://github.com/pinbe/GroupUserFolder.git && \
    pip install -e GroupUserFolder && \
    git clone -b master-egg https://github.com/pinbe/iso_3166_1.git && \
    pip install -e iso_3166_1 && \
    git clone -b zope-2.12-egg https://github.com/pinbe/Photo.git && \
    pip install -e Photo && \
    wget https://github.com/pinbe/photoprint/releases/download/v0.9.1/build.tar.xz && \
    tar xJf build.tar.xz && \
    rm -rf build.tar.xz && \
    pip install -e photoprint && \
    wget https://github.com/pinbe/Portfolio/releases/download/v0.9.1/build.tar.xz && \
    tar xJf build.tar.xz && \
    rm -rf build.tar.xz && \
    pip install -e Portfolio && \
    git clone -b master-egg https://github.com/pinbe/Utf8Splitter.git && \
    pip install -e Utf8Splitter && \
    git clone -b master-egg https://github.com/pinbe/ZTUtils_hotfix.git && \
    pip install -e ZTUtils_hotfix

COPY src/zope.conf  \
     src/zeo.conf \
     src/install.sh $ZOPE_HOME/

USER zope-www

RUN  cd $ZOPE_HOME && \
     ./install.sh && \
     rm ${ZOPE_HOME}/install.sh

USER root

COPY rootfs/ /

EXPOSE 8080

WORKDIR $ZOPE_HOME

ENTRYPOINT ["/init"]
