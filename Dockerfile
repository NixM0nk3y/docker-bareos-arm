#
#
#

FROM arm32v7/debian:buster

LABEL maintainer="Nick Gregory <docker@openenterprise.co.uk>"

ARG BAREOS_VERSION="18.2.8"
ARG BAREOS_SHA256="705e15d3f30e8f656c805e3051e429c26217ffefde8900d1fdd0f2a25b7698f6"

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
    && printf "bareos (19.2.6~openenterprise-1) unstable; urgency=low\n\n  * dummy\n\n -- nobody <nobody@example.com>  Tue, 01 Jan 2019 00:00:00 +0000\n\n" > core/debian/changelog \
    && sh .travis/travis_before_script.sh

STOPSIGNAL SIGTERM
