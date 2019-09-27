ARG OSPL_VERSION=6.9.0
ARG LSSTTS_SALOBJ_VERSION
FROM lsstdm/salrun:${OSPL_VERSION} AS salidl-build

RUN yum -y install java-1.7.0-openjdk-headless \
    && mkdir -p /etc/alternatives/java_sdk_openjdk/jre \
    && ln -s /etc/alternatives/jre_openjdk/bin /etc/alternatives/java_sdk_openjdk/bin \
    && ln -s /etc/alternatives/jre_openjdk/lib /etc/alternatives/java_sdk_openjdk/jre/lib

ENV PYTHON_BUILD_VERSION=3.6m \
    PYTHON_BUILD_LOCATION=/usr \
    LSST_SDK_INSTALL=/tmp/build/ts_sal \
    SAL_WORK_DIR=/tmp/build/ts_sal/test

ARG LSSTTS_IDL_VERSION

WORKDIR /tmp/build
RUN git clone https://github.com/lsst-ts/ts_idl.git \
    && cd ts_idl \
    && git checkout v$LSSTTS_IDL_VERSION

ARG LSSTTS_SAL_VERSION

RUN git clone https://github.com/lsst-ts/ts_sal.git \
    && cd ts_sal \
    && git checkout v$LSSTTS_SAL_VERSION

ARG LSSTTS_XML_VERSION

RUN git clone https://github.com/lsst-ts/ts_xml.git \
    && cd ts_xml \
    && git checkout v$LSSTTS_XML_VERSION \
    && ln -s /tmp/build/ts_xml/sal_interfaces/SALGenerics.xml $SAL_WORK_DIR \
    && ln -s /tmp/build/ts_xml/sal_interfaces/SALSubsystems.xml $SAL_WORK_DIR \
    && ln -s /tmp/build/ts_xml/sal_interfaces/*/*xml $SAL_WORK_DIR

RUN cd $SAL_WORK_DIR \
    && source /opt/lsst/setup_SAL.env \
    && source /tmp/build/ts_sal/setup.env \
    && for csc in `cd /tmp/build/ts_xml/sal_interfaces; ls | grep -v xml`; do \
           salgenerator $csc validate > /dev/null && echo $csc done || exit 1; \
       done

RUN mv /tmp/build/ts_sal/test/idl-templates/validated/*.idl /tmp/build/ts_idl/idl/

FROM lsstdm/salobj:${LSSTTS_SALOBJ_VERSION}

LABEL name="LSST SAL IDL" \
    vendor="LSST" \
    license="GPLv3"

ENV TS_IDL_DIR=/opt/lsst/ts_idl
ENV PYTHONPATH=/opt/lsst/ts_idl/python:$PYTHONPATH

COPY --from=salidl-build /tmp/build/ts_idl/idl /opt/lsst/ts_idl/idl/
COPY --from=salidl-build /tmp/build/ts_idl/python /opt/lsst/ts_idl/python/
COPY --from=salidl-build /tmp/build/ts_idl/qos /opt/lsst/ts_idl/qos/
