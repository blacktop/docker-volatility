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
  python-Levenshtein \
  construct==2.5.5-reupload \
  ctypeslib2 \
  openpyxl \
  haystack==0.36 \
  distorm3 \
  colorama \
  ipython \
  pycoin \
  pytz \
  pysocks \
  requests \
  dpapick \
  && echo "===> Installing Volatility from source..." \
  && cd /tmp \
  && git clone --recursive --branch $VOL_VERSION https://github.com/volatilityfoundation/volatility.git \
  && cd volatility \
  && python3 setup.py build install \
  && echo "===> Installing Community Plugins..." \
  && mkdir /plugins \
  && cd /plugins \
  && git clone https://github.com/volatilityfoundation/community.git \
  && cd community \
  # reset to known working commit
  && git reset --hard 29b07e7223f55e3256e3faee7b712030676ecdec \
  # remove windows only plugins
  && rm -rf /plugins/community/AlexanderTarasenko \
  && rm -rf /plugins/community/MarcinUlikowski \
  && mv /tmp/volatility/contrib/plugins contrib \
  && echo " * Installing ioc_writer..." \
  && cd /tmp \
  && git clone --recursive --branch v0.2.2 https://github.com/mandiant/ioc_writer.git \
  && cd ioc_writer \
  && python3 setup.py install \
  && rm -rf /tmp/* \
  && apk del --purge .build-deps

# Temporary hotfixes for upstream volatility/community import errors
# https://github.com/volatilityfoundation/community/pull/19
RUN cd /plugins/community/YingLi \
  && touch __init__.py \
  && cd /plugins/community/StanislasLejay/linux \
  && touch __init__.py \
  && cd /plugins/community/DatQuoc \
  && touch __init__.py \
  && cd /plugins/community/DimaPshoul \
  && sed -i 's/import volatility.plugins.malware.callstacks as/import/' malthfind.py

VOLUME ["/data"]
VOLUME ["/plugins"]

WORKDIR /data

ENTRYPOINT ["su-exec","nobody","/sbin/tini","--","vol.py","--plugins=/plugins"]
CMD ["-h"]
