FROM ubuntu:latest

MAINTAINER blacktop, https://github.com/blacktop

# Install Volatility
RUN apt-get update -qq \
  && apt-get install -yq software-properties-common \
  && add-apt-repository -y ppa:pi-rho/security \
  && apt-get update -qq \
  && apt-get install -yq volatility \
  && apt-get purge -y --auto-remove software-properties-common \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Define mountable directories.
VOLUME ["/data"]

# Define working directory.
WORKDIR /data

ENTRYPOINT ["volatility"]

CMD ["-h"]
