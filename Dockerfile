#
#
#

FROM arm32v7/debian

LABEL maintainer="Nick Gregory <docker@openenterprise.co.uk>"

ARG BAREOS_VERSION="18.2.6"
ARG BAREOS_SHA256="43ff0546d4d5486bc70db90ccb7fb1f6a3ac3f9b7293de010d2c300b548056d8"

RUN apt-get -y update \
    && apt-get -y dist-upgrade \
    && apt-get -y install curl build-essential cmake sudo

RUN cd /tmp \
    && echo "==> Downloading BareOS..." \
    && curl -fSL https://github.com/bareos/bareos/archive/Release/${BAREOS_VERSION}.tar.gz -o bareos.${BAREOS_VERSION}.tar.gz \
    && sha256sum bareos.${BAREOS_VERSION}.tar.gz \
    && echo "${BAREOS_SHA256}  bareos.${BAREOS_VERSION}.tar.gz" | sha256sum -c - \
    && tar xzf bareos.${BAREOS_VERSION}.tar.gz \
    && cd /tmp/bareos-Release-${BAREOS_VERSION} \ 
    && sh .travis/travis_before_install.sh 

LABEL build=${BAREOS_VERSION}
LABEL image=bareos
RUN cd /tmp \
    && cd /tmp/bareos-Release-${BAREOS_VERSION} \ 
    && cp -a core/platforms/packaging/bareos.changes core/debian/changelog \
    && sh .travis/travis_before_script.sh

STOPSIGNAL SIGTERM
