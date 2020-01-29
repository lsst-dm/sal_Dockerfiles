# To run as service:
#   docker run -td lsstdm/headerservice:<TAGNAME>

ARG LSSTTS_SAL_VERSION
ARG LSSTTS_XML_VERSION
ARG LSSTTS_SALOBJ_VERSION
FROM lsstdm/salobj:${LSSTTS_SAL_VERSION}-${LSSTTS_XML_VERSION}-salobj_${LSSTTS_SALOBJ_VERSION}

LABEL name="LSST AuxTel Header Service Development Environment" \
    vendor="LSST" \
    license="GPLv3"

# These ARGS need to be re-declared
ARG LSSTTS_SAL_VERSION
ARG LSSTTS_XML_VERSION
ARG LSSTTS_RPM_VERSION=$LSSTTS_SAL_VERSION-$LSSTTS_XML_VERSION.el7

# Versions
ARG HEADERSERVICE_VERSION
ARG HSUSER=headerservice

# Pre-reqs for HeaderService
RUN pip3 install fitsio==1.0.4 astropy ipython pyyaml

# SAL rpms using $CCS_IDL_LIST
ARG CCS_IDL_LIST
RUN for ccs in $CCS_IDL_LIST ; do CCS_RPM_LIST=${CCS_RPM_LIST}" $ccs-$LSSTTS_RPM_VERSION"; done; \
    yum install -y $CCS_RPM_LIST

# Copy the idl files from the rpms into the ts_idl folder
RUN cp -pv /opt/lsst/ts_sal/idl/sal_revCoded_*.idl /opt/lsst/ts_idl/idl/

# --- Install HeaderService ----
ARG PRODUCT=HeaderService
ARG VERSION=$HEADERSERVICE_VERSION
ARG PRODUCT_DIR=/opt/lsst/$PRODUCT/$VERSION
# Create the init env file
RUN echo "# Load up ATHeaderService Environment" > /opt/lsst/setup_HeaderService.env \
    && echo "source /opt/lsst/setup_salobj.env " >> /opt/lsst/setup_HeaderService.env \
    && echo "export PYTHONPATH=\${PYTHONPATH}:/opt/lsst/ts_sal/lib " >> /opt/lsst/setup_HeaderService.env

# Git clone and version checkout
RUN mkdir -p /tmp/repos \
    && cd /tmp/repos \
    && git clone https://github.com/lsst-dm/$PRODUCT.git -b $VERSION\
    && cd $PRODUCT \
    && mkdir -p $PRODUCT_DIR \
    && export PYTHONPATH=$PYTHONPATH:$PRODUCT_DIR/python \
    && python3 setup.py install --prefix=$PRODUCT_DIR --install-lib=$PRODUCT_DIR/python
# Add to the init file
RUN echo "source $PRODUCT_DIR/setpath.sh $PRODUCT_DIR" >> /opt/lsst/setup_HeaderService.env
RUN echo "export LSST_DDS_DOMAIN=auxtelpath" >> /opt/lsst/setup_HeaderService.env

# Clen up files
RUN rm -rf /tmp/repos

# --- End of HeaderService and salpytools ----

# Add $HSUSER as user
RUN useradd -ms /bin/bash $HSUSER
RUN usermod -aG wheel $HSUSER

ENV USER $HSUSER
ENV HOME /home/$HSUSER
ENV SHELL /bin/bash

USER $HSUSER
WORKDIR /home/$HSUSER

CMD source /opt/lsst/setup_HeaderService.env \
    && ATHS_salobj -c $HEADERSERVICE_DIR/etc/conf/atTelemetry.yaml --send_efd_message
