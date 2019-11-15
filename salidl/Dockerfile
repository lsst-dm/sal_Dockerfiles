ARG OSPL_VERSION=6.9.0
FROM lsstdm/salrun:${OSPL_VERSION} 
LABEL name="LSST SAL IDL" \
    vendor="LSST" \
    license="GPLv3"

ARG LSSTTS_IDL_VERSION

WORKDIR /opt/lsst
RUN git clone https://github.com/lsst-ts/ts_idl.git \
    && cd ts_idl \
    && git checkout v$LSSTTS_IDL_VERSION

ENV TS_IDL_DIR=/opt/lsst/ts_idl
ENV PYTHONPATH=/opt/lsst/ts_idl/python:$PYTHONPATH

RUN echo "source /opt/lsst/setup_SAL.env" > /opt/lsst/setup_salidl.env \
  && echo "export TS_IDL_DIR=/opt/lsst/ts_idl" >> /opt/lsst/setup_salidl.env \
  && echo "export PYTHONPATH=/opt/lsst/ts_idl/python:\${PYTHONPATH}" >> /opt/lsst/setup_salidl.env
