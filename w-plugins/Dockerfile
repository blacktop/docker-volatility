FROM blacktop/yara:3.5

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
  && echo "===> Installing Volatility from source..." \
  && cd /tmp \
  && git clone --recursive --branch $VOL_VERSION https://github.com/volatilityfoundation/volatility.git \
  && cd volatility \
  && python setup.py build install \
  && echo "===> Installing Community Plugins..." \
  && mkdir /plugins \
  && cd /plugins \
  && git clone https://github.com/volatilityfoundation/community.git \
  && mv /tmp/volatility/contrib/plugins contrib \
  && echo " * Installing ioc_writer..." \
  && cd /tmp \
  && git clone --recursive --branch v0.2.2 https://github.com/mandiant/ioc_writer.git \
  && cd ioc_writer \
  && python setup.py install \
  && rm -rf /tmp/* \
  && apk del --purge .build-deps

VOLUME ["/data"]
VOLUME ["/plugins"]

WORKDIR /data

ENTRYPOINT ["su-exec","nobody","/sbin/tini","--","vol.py","--plugins=/plugins"]
CMD ["-h"]
