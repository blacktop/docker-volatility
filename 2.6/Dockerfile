FROM blacktop/yara:4.2

LABEL maintainer "https://github.com/blacktop"

ENV VOL_VERSION 2.6.1

# Install Volatility Dependancies
RUN apk add --no-cache ca-certificates zlib py3-pillow py3-crypto py3-lxml py3-setuptools
RUN apk add --no-cache -t .build-deps \
  openssl-dev \
  python3-dev \
  build-base \
  zlib-dev \
  libc-dev \
  jpeg-dev \
  automake \
  autoconf \
  py3-pip \
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
  && cd /tmp \
  && echo "===> Installing Volatility from source..." \
  && git clone --recursive --branch $VOL_VERSION https://github.com/volatilityfoundation/volatility.git \
  && cd volatility \
  && python3 setup.py build install \
  && rm -rf /tmp/* \
  && apk del --purge .build-deps

VOLUME ["/data"]
VOLUME ["/plugins"]

WORKDIR /data

ENTRYPOINT ["su-exec","nobody","/sbin/tini","--","vol.py"]
CMD ["-h"]
