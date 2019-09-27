ARG LSSTTS_SAL_VERSION
ARG LSSTTS_XML_VERSION
FROM lsstdm/salidl:${LSSTTS_SAL_VERSION}-${LSSTTS_XML_VERSION}

ARG LSSTTS_SAL_VERSION
ARG LSSTTS_XML_VERSION
ARG LSSTTS_RPM_VERSION=$LSSTTS_SAL_VERSION-$LSSTTS_XML_VERSION.el7

LABEL name="LSST AuxTel Header Service Development Environment" \
    vendor="LSST" \
    license="GPLv3"

RUN yum -y install make patch wget

# Versions
ARG HEADERSERVICE_VERSION=1.0.0
ARG SALPYTOOLS_VERSION=0.9.7
ARG FITSIO_VERSION=1.0.4
ARG GIT_LSST_DM="https://github.com/lsst-dm"
ARG INSTALL_PATH=/opt/lsst
ARG REPOS_TMP=/tmp/repos
ARG HSUSER=headerservice

RUN yum -y install python36-devel gcc-c++ make patch wget
RUN pip3 install fitsio==$FITSIO_VERSION

RUN yum install -y \
    ATArchiver-$LSSTTS_RPM_VERSION \
    ATHeaderService-$LSSTTS_RPM_VERSION \
    ATCamera-$LSSTTS_RPM_VERSION \
    EFD-$LSSTTS_RPM_VERSION \
    ATPtg-$LSSTTS_RPM_VERSION \
    ATMCS-$LSSTTS_RPM_VERSION \
    ATSpectrograph-$LSSTTS_RPM_VERSION \
    ATTCS-$LSSTTS_RPM_VERSION \
    ATHexapod-$LSSTTS_RPM_VERSION


# --- Install HeaderService and salpytools ----
ARG PRODUCT=HeaderService
ARG VERSION=$HEADERSERVICE_VERSION
ARG PRODUCT_DIR=$INSTALL_PATH/$PRODUCT/$VERSION
# Create the init env file
RUN echo "# This loads /opt/lsst/setup_SAL.env" > $INSTALL_PATH/setup_HeaderService.env \
    && echo "source $INSTALL_PATH/setup_salobj.env " >> $INSTALL_PATH/setup_HeaderService.env
# Git clone and version checkout
RUN mkdir -p $REPOS_TMP \
    && cd $REPOS_TMP \
    && git clone $GIT_LSST_DM/$PRODUCT.git -b $VERSION\
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
RUN mkdir -p $REPOS_TMP \
    && cd $REPOS_TMP \
    && git clone $GIT_LSST_DM/$PRODUCT.git -b $VERSION\
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
