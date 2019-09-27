ARG OSPL_VERSION=6.9.0
FROM lsstdm/salrun:${OSPL_VERSION} AS salobj-build

RUN yum -y install gcc-c++ python36-devel

RUN source /opt/lsst/setup_SAL.env \
    && cd $OSPL_HOME/tools/python/src \
    && python3 setup.py install

ARG LSSTTS_SALOBJ_VERSION

RUN git clone https://github.com/lsst-ts/ts_salobj.git \
    && cd ts_salobj \
    && git checkout v$LSSTTS_SALOBJ_VERSION \
    && python3 setup.py install

FROM lsstdm/salrun:${OSPL_VERSION}

LABEL name="LSST salobj Runtime Environment" \
    vendor="LSST" \
    license="GPLv3"

COPY --from=salobj-build /usr/local/lib64/python3.6/site-packages/* /usr/local/lib64/python3.6/site-packages/
COPY --from=salobj-build /usr/local/lib/python3.6/site-packages/* /usr/local/lib/python3.6/site-packages/
COPY --from=salobj-build /usr/local/bin/purge_topics.py /usr/local/bin/run_test_csc.py /usr/local/bin/
