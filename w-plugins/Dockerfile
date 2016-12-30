FROM blacktop/yara:3.4

MAINTAINER blacktop, https://github.com/blacktop

ENV VOL_VERSION 2.6

# Install Volatility Dependancies
RUN apk-install ca-certificates zlib py-pillow py-crypto py-lxml py-setuptools
RUN apk-install -t .build-deps \
                   openssl-dev \
                   python-dev \
                   build-base \
                   zlib-dev \
                   libc-dev \
                   jpeg-dev \
                   automake \
                   autoconf \
                   py-pip \
                   git \
  && export PIP_NO_CACHE_DIR=off \
  && export PIP_DISABLE_PIP_VERSION_CHECK=on \
  && pip install --upgrade pip wheel \
  && pip install simplejson \
                 construct \
                 openpyxl \
                 haystack \
                 distorm3 \
                 colorama \
                 ipython \
                 pycoin \
                 pytz \
  && set -x \
  && cd /tmp \
  && echo "Installing Volatility from source..." \
  && git clone --recursive --branch $VOL_VERSION https://github.com/volatilityfoundation/volatility.git \
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
  && apk del --purge .build-deps

VOLUME ["/data"]
VOLUME ["/plugins"]

WORKDIR /data

ENTRYPOINT ["gosu","nobody","/sbin/tini","--","vol.py"]

CMD ["-h"]
