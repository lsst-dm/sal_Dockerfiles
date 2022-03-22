# To run as service:
#   docker run -td lsstdm/headerservice:<TAGNAME>

ARG LSSTTS_SAL_VERSION
ARG LSSTTS_XML_VERSION
ARG LSSTTS_SALOBJ_VERSION
FROM lsstdm/salrun:${LSSTTS_SAL_VERSION}-${LSSTTS_XML_VERSION}-salobj_${LSSTTS_SALOBJ_VERSION}

LABEL name="LSST AuxTel Header Service Development Environment" \
    vendor="LSST" \
    license="GPLv3"

# These ARGS need to be re-declared
ARG LSSTTS_SAL_VERSION
ARG LSSTTS_XML_VERSION
ARG LSSTTS_RPM_VERSION=$LSSTTS_SAL_VERSION-$LSSTTS_XML_VERSION.el7
ARG MINICONDA_PATH

# Versions
ARG HEADERSERVICE_VERSION
ARG HSUSER=headerservice

# Pre-reqs for HeaderService
RUN source ${MINICONDA_PATH}/bin/activate \
    && conda install -y python=3.8 fitsio pyyaml \
    # Need to downgrade to setuptools=59.8.0
    && conda install -y setuptools=59.8.0

# --- Install HeaderService ----
ARG PRODUCT=HeaderService
ARG VERSION=$HEADERSERVICE_VERSION
ARG PRODUCT_DIR=/opt/lsst/$PRODUCT/$VERSION
ENV MINICONDA=${MINICONDA_PATH}


# Git clone and version checkout
RUN source ${MINICONDA_PATH}/bin/activate \
    && mkdir -p /tmp/repos \
    && cd /tmp/repos \
    && git clone https://github.com/lsst-dm/$PRODUCT.git -b $VERSION\
    && cd $PRODUCT \
    && mkdir -p $PRODUCT_DIR \
    && export PYTHONPATH=$PYTHONPATH:$PRODUCT_DIR/python \
    && python setup.py install --prefix=$PRODUCT_DIR --install-lib=$PRODUCT_DIR/python

# Create init file
RUN echo "# Load up HeaderService Environment" > /opt/lsst/setup_HeaderService.env \
   && echo "source /opt/lsst/setup_SAL.env" >> /opt/lsst/setup_HeaderService.env \
   && echo "source ${MINICONDA}/bin/activate" >> /opt/lsst/setup_HeaderService.env \
   && echo "source $PRODUCT_DIR/setpath.sh $PRODUCT_DIR" >> /opt/lsst/setup_HeaderService.env

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

#CMD source /opt/lsst/setup_HeaderService.env \
#    && ATHS_salobj -c $HEADERSERVICE_DIR/etc/conf/atTelemetry.yaml
