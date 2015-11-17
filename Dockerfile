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
  && apk --update add ca-certificates zlib py-pillow py-crypto $buildDeps \
  && pip install --upgrade pip setuptools wheel \
  && pip install distorm3 \
                 openpyxl \
                 ipython \
                 pytz \
  && cd /tmp \
  && git clone --recursive --branch 2.5 https://github.com/volatilityfoundation/volatility.git \
  && cd volatility \
  && python setup.py build install \
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
