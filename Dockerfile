FROM blacktop/yara

MAINTAINER blacktop, https://github.com/blacktop

# Install Volatility Dependancies
RUN apk-install ca-certificates zlib py-pillow py-crypto py-lxml py-setuptools
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
                 openpyxl \
                 ipython \
                 pycoin \
                 pytz \
  && set -x \
  && cd /tmp \
  && git clone --recursive https://github.com/volatilityfoundation/volatility.git \
  && cd volatility \
  && python setup.py build install \
  && cd /tmp \
  && echo "Installing ioc_writer..." \
  && git clone --recursive --branch v0.2.2 https://github.com/mandiant/ioc_writer.git \
  && cd ioc_writer \
  && python setup.py install \
  && echo "Installing Community Plugins..." \
  && mkdir /plugins \
  && cd /plugins \
  && git clone https://github.com/volatilityfoundation/community.git \
  && rm -rf /tmp/* \
  && apk del --purge build-deps

# Define mountable directories.
VOLUME ["/data"]
VOLUME ["/plugins"]

# Define working directory.
WORKDIR /data

ENTRYPOINT ["vol.py"]

CMD ["-h"]
