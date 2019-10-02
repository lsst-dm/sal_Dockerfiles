ARG LSSTTS_SAL_VERSION
ARG LSSTTS_XML_VERSION
FROM lsstdm/salidl:${LSSTTS_SAL_VERSION}-${LSSTTS_XML_VERSION}

LABEL name="LSST salobj Runtime Environment" \
    vendor="LSST" \
    license="GPLv3"

ARG LSSTTS_SALOBJ_VERSION

RUN mkdir -p /opt/lsst \
    && cd /opt/lsst  \
    && git clone https://github.com/lsst-ts/ts_salobj.git \
    && cd ts_salobj \
    && git checkout v$LSSTTS_SALOBJ_VERSION \
    && pip3 install -e .

ENV TS_SALOBJ_DIR=/opt/lsst/ts_salobj
ENV PYTHONPATH=${TS_SALOBJ_DIR}/python:$PYTHONPATH
