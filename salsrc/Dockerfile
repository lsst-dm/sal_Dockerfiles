ARG OSPL_VERSION=6.9.0
FROM lsstdm/salrun:${OSPL_VERSION}

LABEL name="LSST salsrc Runtime Environment" \
    vendor="LSST" \
    license="GPLv3"

RUN yum -y install java-1.7.0-openjdk-headless \
    && mkdir -p /etc/alternatives/java_sdk_openjdk/jre \
    && ln -s /etc/alternatives/jre_openjdk/bin /etc/alternatives/java_sdk_openjdk/bin \
    && ln -s /etc/alternatives/jre_openjdk/lib /etc/alternatives/java_sdk_openjdk/jre/lib

# code version
ARG LSSTTS_SAL_VERSION
ARG LSSTTS_XML_VERSION
ARG CCS_IDL_LIST
# Locations
ARG INSTALL_PATH=/opt/lsst

# Build from ts_sal/ts_xml from source using sal_install_fromSource.sh script
RUN mkdir -p /tmp/salbuild
COPY ./sal_install_fromSource.sh /tmp/salbuild
ENV CCS_IDL_LIST=$CCS_IDL_LIST
RUN cd /tmp/salbuild \
    && ./sal_install_fromSource.sh  -v_sal v$LSSTTS_SAL_VERSION -v_xml v$LSSTTS_XML_VERSION -p $INSTALL_PATH/sal-home \
    && rm -rf /tmp/salbuild
