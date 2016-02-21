FROM blacktop/yara

MAINTAINER blacktop, https://github.com/blacktop

# Install Volatility Dependancies
<<<<<<< HEAD
RUN buildDeps='autoconf \
               automake \
               gcc \
               git \
               libc-dev \
               make \
               openssl-dev \
               py-pip \
               python-dev \
               jpeg-dev \
               zlib-dev' \
  && set -x \
  && apk --update add ca-certificates zlib py-pillow py-crypto $buildDeps \
  && pip install --upgrade pip setuptools wheel \
  && pip install distorm3 \
=======
RUN apk-install ca-certificates zlib py-pillow py-crypto py-lxml
RUN apk-install -t build-deps build-base \
                              autoconf \
                              automake \
                              libc-dev \
                              git \
                              openssl-dev \
                              python-dev \
                              py-pip \
                              jpeg-dev \
                              zlib-dev \
  && pip install --upgrade pip wheel \
  && pip install simplejson \
                 construct \
                 colorama \
                 haystack \
                 distorm3 \
>>>>>>> master
                 openpyxl \
                 ipython \
                 pycoin \
                 pytz \
  && set -x \
  && cd /tmp \
  && git clone --recursive --branch 2.5 https://github.com/volatilityfoundation/volatility.git \
  && cd volatility \
  && python setup.py build install \
<<<<<<< HEAD
=======
  && cd /tmp \
  && echo "Installing ioc_writer..." \
  && git clone --recursive --branch v0.2.2 https://github.com/mandiant/ioc_writer.git \
  && cd ioc_writer \
  && python setup.py install \
>>>>>>> master
  && echo "Installing Community Plugins..." \
  && mkdir /plugins \
  && cd /plugins \
  && git clone https://github.com/volatilityfoundation/community.git \
<<<<<<< HEAD
  && apk del --purge $buildDeps \
  && rm -rf /tmp/* /root/.cache /var/cache/apk/*
=======
  && rm -rf /tmp/* \
  && apk del --purge build-deps
>>>>>>> master

# Define mountable directories.
VOLUME ["/data"]
VOLUME ["/plugins"]

# Define working directory.
WORKDIR /data

ENTRYPOINT ["vol.py"]

CMD ["-h"]
