ARG LSSTTS_SAL_VERSION
ARG LSSTTS_XML_VERSION

FROM lsstdm/salidl:${LSSTTS_SAL_VERSION}-${LSSTTS_XML_VERSION}

LABEL name="LSST salobj Runtime Environment" \
    vendor="LSST" \
    license="GPLv3"

ARG LSSTTS_SALOBJ_VERSION
ARG MINICONDA_PATH

RUN source ${MINICONDA_PATH}/bin/activate \
    && conda install -c lsstts python=3.8 ts-salobj=${LSSTTS_SALOBJ_VERSION}
