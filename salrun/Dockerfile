FROM centos:7

ARG MINICONDA_PATH

LABEL name="LSST SAL Runtime Dependencies" \
    vendor="LSST" \
    license="GPLv3"

RUN yum -y install git make patch wget \
    gcc-c++ gettext

# Need to install the rpm for OpenSplice
ARG OSPL_VERSION=6.9.0
ARG OSPL_RPM_VERSION=6.9.0-8
ARG LSSTTS_DDS_VERSION=6.9.190925_7
ARG LSSTTS_DDSCONFIG_VERSION=v0.1.0

# To set ts-idl
ARG LSSTTS_IDL_VERSION
ARG LSSTTS_XML_VERSION
ARG LSSTTS_SAL_VERSION

COPY lsst-ts-nexus.repo /etc/yum.repos.d
COPY setup_SAL.env /opt/lsst/setup_SAL.env.template

ARG NEXUS_USER
ARG NEXUS_PASS
ENV NEXUS_USER=${NEXUS_USER}
ENV NEXUS_PASS=${NEXUS_PASS}

COPY lsst-ts-nexus-private-template.repo .
RUN envsubst < lsst-ts-nexus-private-template.repo > /etc/yum.repos.d/lsst-ts-nexus-private.repo

RUN yum -y install OpenSpliceDDS-$OSPL_RPM_VERSION
ENV OSPL_HOME /opt/OpenSpliceDDS/V${OSPL_VERSION}/HDE/x86_64.linux

# Now we remove the repo file with password
RUN rm /etc/yum.repos.d/lsst-ts-nexus-private.repo

# Install the OSPL configuration
RUN cd /opt/lsst \
    && git clone https://github.com/lsst-ts/ts_ddsconfig --branch v${LSSTTS_DDSCONFIG_VERSION}

# Get the setup conf
RUN echo "export OSPL_HOME=/opt/OpenSpliceDDS/V${OSPL_VERSION}/HDE/x86_64.linux" > /opt/lsst/setup_SAL.env \
    && echo "export OSPL_URI=file:///opt/lsst/ts_ddsconfig/config/ospl-shmem.xml" >> /opt/lsst/setup_SAL.env \
    && cat /opt/lsst/setup_SAL.env.template >> /opt/lsst/setup_SAL.env

ENV OSPL_URI file:///opt/lsst/ts_ddsconfig/config/ospl-shmem.xml

# Conda installation
RUN mkdir -p ${MINICONDA_PATH} \
    && cd ${MINOCONDA_PATH} \
    && wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    && chmod +x Miniconda3-latest-Linux-x86_64.sh \
    && ./Miniconda3-latest-Linux-x86_64.sh -b -p ${MINICONDA_PATH} -u

# Start the env and add channels
RUN source $MINICONDA_PATH/bin/activate \
    && conda config --add channels conda-forge

# Install python ts-dds/ts-idl and ts-salobj using conda
RUN source ${MINICONDA_PATH}/bin/activate \
    && conda install -y cython \
    && conda install -y -c lsstts -c lsstts/label/dev python=3.8 ts-dds=$LSSTTS_DDS_VERSION \
    && conda install -y -c lsstts -c lsstts/label/dev python=3.8 ts-idl=${LSSTTS_IDL_VERSION}_${LSSTTS_XML_VERSION}_${LSSTTS_SAL_VERSION} \
    && conda install -y -c lsstts -c lsstts/label/dev python=3.8 ts-salobj=${LSSTTS_SALOBJ_VERSION}
#    && conda install -y -c lsstts -c lsstts/label/dev python=3.8 ts-ddsconfig=${LSSTTS_DDSCONFIG_VERSION}
