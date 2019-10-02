ARG LSSTTS_SAL_VERSION
ARG LSSTTS_XML_VERSION
ARG LSSTTS_SALOBJ_VERSION
FROM lsstdm/salobj:${LSSTTS_SAL_VERSION}-${LSSTTS_XML_VERSION}-${LSSTTS_SALOBJ_VERSION}

LABEL name="LSST AuxTel Header Service Development Environment" \
    vendor="LSST" \
    license="GPLv3"

# These ARGS need to be re-declared
ARG LSSTTS_SAL_VERSION
ARG LSSTTS_XML_VERSION
ARG LSSTTS_RPM_VERSION=$LSSTTS_SAL_VERSION-$LSSTTS_XML_VERSION.el7

# Versions
ARG HEADERSERVICE_VERSION=1.0.1
ARG SALPYTOOLS_VERSION=0.9.7
ARG FITSIO_VERSION=1.0.4
ARG INSTALL_PATH=/opt/lsst
ARG HSUSER=headerservice

# Pre-reqs for HeaderService
RUN pip3 install fitsio==$FITSIO_VERSION
RUN pip3 install astropy ipython pyyaml

# SAL rpms using $CCS_IDL_LIST
ARG CCS_IDL_LIST
RUN for ccs in $CCS_IDL_LIST ; do CCS_RPM_LIST=${CCS_RPM_LIST}" $ccs-$LSSTTS_RPM_VERSION"; done; \
    yum install -y $CCS_RPM_LIST


# --- Install HeaderService and salpytools ----
ARG PRODUCT=HeaderService
ARG VERSION=$HEADERSERVICE_VERSION
ARG PRODUCT_DIR=$INSTALL_PATH/$PRODUCT/$VERSION
# Create the init env file
RUN echo "# This loads /opt/lsst/setup_SAL.env" > $INSTALL_PATH/setup_HeaderService.env \
    && echo "source $INSTALL_PATH/setup_salobj.env " >> $INSTALL_PATH/setup_HeaderService.env
# Git clone and version checkout
RUN mkdir -p /tmp/repos \
    && cd /tmp/repos \
    && git clone https://github.com/lsst-dm/$PRODUCT.git -b $VERSION\
    && cd $PRODUCT \
    && mkdir -p $PRODUCT_DIR \
    && export PYTHONPATH=$PYTHONPATH:$PRODUCT_DIR/python \
    && python3 setup.py install --prefix=$PRODUCT_DIR --install-lib=$PRODUCT_DIR/python
# Add to the init file
RUN echo "source $PRODUCT_DIR/setpath.sh $PRODUCT_DIR" >> $INSTALL_PATH/setup_HeaderService.env

# Install the salpytools
ARG PRODUCT=salpytools
ARG VERSION=$SALPYTOOLS_VERSION
ARG PRODUCT_DIR=$INSTALL_PATH/$PRODUCT/$VERSION
# Git clone and version checkout
RUN mkdir -p /tmp/repos \
    && cd /tmp/repos \
    && git clone https://github.com/lsst-dm/$PRODUCT.git -b $VERSION\
    && cd $PRODUCT \
    && mkdir -p $PRODUCT_DIR \
    && export PYTHONPATH=$PYTHONPATH:$PRODUCT_DIR/python \
    && python3 setup.py install --prefix=$PRODUCT_DIR --install-lib=$PRODUCT_DIR/python

# Add to the init file
RUN echo "source $PRODUCT_DIR/setpath.sh $PRODUCT_DIR" >> $INSTALL_PATH/setup_HeaderService.env
RUN echo "export LSST_DDS_DOMAIN=auxtelpath" >> $INSTALL_PATH/setup_HeaderService.env
# --- End of HeaderService and salpytools ----

# Add $HSUSER as user
RUN useradd -ms /bin/bash $HSUSER
RUN usermod -aG wheel $HSUSER

ENV USER $HSUSER
ENV HOME /home/$HSUSER
ENV SHELL /bin/bash

USER $HSUSER
WORKDIR /home/$HSUSER
