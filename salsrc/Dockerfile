
ARG salrpm_image

FROM $salrpm_image

# code version
ARG TS_SAL_VERSION=v3.10.0
ARG TS_XML_VERSION=v3.10.0

# Locations
ARG INSTALL_PATH=/opt/lsst

# Build from ts_sal/ts_xml from source using sal_install_fromSource.sh script
RUN mkdir -p /tmp/salbuild
COPY ./sal_install_fromSource.sh /tmp/salbuild
RUN cd /tmp/salbuild \
    && ./sal_install_fromSource.sh  -v_sal $TS_SAL_VERSION -v_xml $TS_XML_VERSION -p $INSTALL_PATH/sal-home \
    && rm -rf /tmp/salbuild

