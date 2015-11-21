FROM blacktop/yara

MAINTAINER blacktop, https://github.com/blacktop

# Install Volatility Dependancies
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
  && apk --update add $buildDeps ca-certificates zlib py-pillow py-crypto py-lxml \
  && pip install --upgrade pip setuptools wheel \
  && pip install simplejson \
                 construct \
                 colorama \
                 haystack \
                 distorm3 \
                 openpyxl \
                 ipython \
                 pycoin \
                 pytz \
  && cd /tmp \
  && git clone https://github.com/volatilityfoundation/volatility.git \
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
  && apk del --purge $buildDeps \
  && rm -rf /tmp/* /root/.cache /var/cache/apk/*

# Define mountable directories.
VOLUME ["/data"]
VOLUME ["/plugins"]

# Define working directory.
WORKDIR /data

ENTRYPOINT ["vol.py"]

CMD ["-h"]
