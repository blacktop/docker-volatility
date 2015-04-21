![volatility-logo](https://code.google.com/p/volatility/logo?cct=1387506588) Volatility Dockerfile
==================

This repository contains a **Dockerfile** of [Volatility](https://github.com/volatilityfoundation/volatility) for [Docker](https://www.docker.io/)'s [trusted build](https://index.docker.io/u/blacktop/volatility/) published to the public [Docker Registry](https://index.docker.io/).

### Dependencies

* [blacktop/yara](https://registry.hub.docker.com/u/blacktop/yara/)

### Image Tags
```bash
$ docker images

REPOSITORY                 TAG           VIRTUAL SIZE
blacktop/volatility        latest        390 MB
```

### Installation

1. Install [Docker](https://www.docker.io/).

2. Download [trusted build](https://index.docker.io/u/blacktop/volatility/) from public [Docker Registry](https://index.docker.io/): `docker pull blacktop/volatility`

#### Alternatively, build an image from Dockerfile
```bash
$ docker build -t blacktop/volatility github.com/blacktop/docker-volatility
```
### Usage
```bash
$ docker run -i -t -v /path/to/mem:/data:rw blacktop/volatility -f windows.vmem psscan
```
#### Output:
```bash

```

### Todo
- [x] Install/Run Volatility
- [ ] Start Daemon and watch folder with supervisord
- [ ] Have container take a URL as input and download/scan memory dump
