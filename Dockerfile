# FROM debian:wheezy
FROM blacktop/yara

MAINTAINER blacktop, https://github.com/blacktop

# Install Volatility
RUN buildDeps='build-essential \
               python-dev \
               python-pip' \
  && set -x \
  && apt-get update -qq \
  && apt-get install -yq $buildDeps \
                         python \
                         git-core \
  && pip install --upgrade pip \
  && /usr/local/bin/pip install --upgrade distorm3 \
                                          pycrypto \
                                          Pillow \
                                          openpyxl \
                                          ipython \
                                          pytz \
  && apt-get purge -y --auto-remove $buildDeps \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install Cuckoo Sandbox and remove install dir after to conserve space
RUN cd /tmp \
  && git clone https://github.com/volatilityfoundation/volatility.git \
  && cd volatility \
  && python setup.py build \
  && python setup.py install \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Define mountable directories.
VOLUME ["/data"]

# Define working directory.
WORKDIR /data

ENTRYPOINT ["vol.py"]

CMD ["-h"]
