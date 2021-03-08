ARG OSPL_VERSION=6.9.0
FROM lsstdm/salrun:${OSPL_VERSION}
LABEL name="LSST SAL IDL" \
    vendor="LSST" \
    license="GPLv3"

ARG LSSTTS_IDL_VERSION
ARG LSSTTS_XML_VERSION
ARG LSSTTS_SAL_VERSION
ARG MINICONDA_PATH

# This will install all of the sal_revCoded_*.idl files in $MINICONDA_PATH/lib/python3.7/idl
RUN source ${MINICONDA_PATH}/bin/activate \
    && conda install -c lsstts -c lsstts/label/dev python=3.8 ts-idl=${LSSTTS_IDL_VERSION}_${LSSTTS_XML_VERSION}_${LSSTTS_SAL_VERSION}

#ENV TS_IDL_DIR=/opt/lsst/ts_idl
#ENV PYTHONPATH=/opt/lsst/ts_idl/python:$PYTHONPATH
#ENV MINICONDA=${MINICONDA_PATH}

#RUN echo "source /opt/lsst/setup_SAL.env" > /opt/lsst/setup_salidl.env \
#  && echo "source ${MINICONDA}/bin/activate" >> /opt/lsst/setup_salidl.env \
#  && echo "export TS_IDL_DIR=/opt/lsst/ts_idl" >> /opt/lsst/setup_salidl.env \
#  && echo "export PYTHONPATH=/opt/lsst/ts_idl/python:\${PYTHONPATH}" >> /opt/lsst/setup_salidl.env
