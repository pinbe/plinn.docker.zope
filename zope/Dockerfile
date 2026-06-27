FROM python:2.7
LABEL maintener="Benoît Pin <benoit.pin@gmail.com>"

ENV PIP=9.0.3 \
    ZC_BUILDOUT=2.11.2 \
    SETUPTOOLS=38.7.0 \
    PYTHON=python \
    CONFIG=base.cfg \
    ZOPE_HOME=/opt/zope

# Debian
RUN mkdir -p $ZOPE_HOME/var &&  \
    groupadd -g 500 zope-www && \
    useradd  -g 500 -u 500 -m -s /bin/bash zope-www && \
    chown -R 500:500 $ZOPE_HOME && \
    sed -i s/deb.debian.org/archive.debian.org/g /etc/apt/sources.list && \
    sed -i 's|security.debian.org|archive.debian.org/|g' /etc/apt/sources.list && \
    sed -i '/buster-updates/d' /etc/apt/sources.list && \
    apt-get update

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
RUN wget https://github.com/pinbe/Plinn/releases/download/v0.9.0/build.tar.xz && \
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
    git clone -b zope-2.13-egg https://github.com/pinbe/photoprint.git && \
    pip install -e photoprint && \
    wget https://github.com/pinbe/Portfolio/releases/download/v0.9.0/build.tar.xz && \
    tar xJf build.tar.xz && \
    rm -rf build.tar.xz && \
    pip install -e Portfolio && \
    git clone -b master-egg https://github.com/pinbe/Utf8Splitter.git && \
    pip install -e Utf8Splitter && \
    git clone -b master-egg https://github.com/pinbe/ZTUtils_hotfix.git && \
    pip install -e ZTUtils_hotfix

# # Plinn zope products
# RUN pip install git+https://github.com/pinbe/Plinn.git@zope-2.13-egg && \
#     pip install git+https://github.com/pinbe/ckeditor.git@ckeditor4.14 && \
#     pip install git+https://github.com/pinbe/Epoz.git@master-egg && \
#     pip install git+https://github.com/pinbe/GroupUserFolder.git@zope-2.13-egg && \
#     pip install git+https://github.com/pinbe/iso_3166_1.git@master-egg && \
#     pip install git+https://github.com/pinbe/Photo.git@zope-2.12-egg && \
#     pip install git+https://github.com/pinbe/photoprint.git@zope-2.13-egg && \
#     pip install git+https://github.com/pinbe/Portfolio.git@zope-2.13-egg && \
#     pip install git+https://github.com/pinbe/Utf8Splitter.git@master-egg && \
#     pip install git+https://github.com/pinbe/ZTUtils_hotfix.git@master-egg

#COPY src/docker-entrypoint.sh    \
#     src/zope-setup.sh           \
#     src/configure.py            \
#     src/last-built-cfg.py       /
#
#COPY src/versions.cfg            \
#     src/sources.cfg             \
#     src/zope.cfg                \
#     src/base.cfg                \
#     src/install.sh              $ZOPE_HOME/
#
#RUN buildDeps="dpkg-dev gcc libbz2-dev libc6-dev libjpeg62-turbo-dev libopenjp2-7-dev libpcre3-dev libssl-dev libtiff5-dev libxml2-dev libxslt1-dev wget zlib1g-dev" \
#    && runDeps="gosu libjpeg62 libopenjp2-7 libtiff5 libxml2 libxslt1.1 lynx netcat poppler-utils rsync wv" \
#    && apt-get update \
#    && apt-get install -y --no-install-recommends $buildDeps \
#    && pip install pip==$PIP setuptools==$SETUPTOOLS zc.buildout==$ZC_BUILDOUT \
#    && cd $ZOPE_HOME && ./install.sh \
#    && apt-get purge -y --auto-remove $buildDeps \
#    && apt-get install -y --no-install-recommends $runDeps \
#    && rm -rf /var/lib/apt/lists/*
#
#EXPOSE 8080
#
#WORKDIR $ZOPE_HOME
#
#HEALTHCHECK --interval=1m --timeout=5s --start-period=1m \
#  CMD nc -z -w5 127.0.0.1 8080 || exit 1
#
#USER zope-www
#
#ENTRYPOINT ["/docker-entrypoint.sh"]
#CMD ["start"]
