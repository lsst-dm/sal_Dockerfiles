FROM centos:7

ARG MINICONDA_PATH

LABEL name="LSST SAL Runtime Dependencies" \
    vendor="LSST" \
    license="GPLv3"

RUN yum -y install epel-release
RUN yum -y install python36 python36-devel python36-pip \
    git make patch wget \
    gcc-c++

# Need to install the rpm for OpenSplice
ARG OSPL_VERSION=6.9.0
ARG OSPL_RPM_VERSION=6.9.0-8
ARG LSSTTS_DDS_VERSION=6.9.190925_7

COPY lsst-ts-nexus.repo /etc/yum.repos.d
COPY setup_SAL.env /opt/lsst/setup_SAL.env

RUN yum -y install OpenSpliceDDS-$OSPL_RPM_VERSION
ENV OSPL_HOME /opt/OpenSpliceDDS/V${OSPL_VERSION}/HDE/x86_64.linux

# Conda installation, for Py37 and beyond
RUN mkdir -p ${MINICONDA_PATH} \
    && cd ${MINOCONDA_PATH} \
    && wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    && chmod +x Miniconda3-latest-Linux-x86_64.sh \
    && ./Miniconda3-latest-Linux-x86_64.sh -b -p ${MINICONDA_PATH} -u

# Start the env and add channels
RUN source $MINICONDA_PATH/bin/activate \
    && conda config --add channels conda-forge

# Install python dds using conda
RUN source ${MINICONDA_PATH}/bin/activate \
    && conda install -c lsstts python=3.7 ts-dds==v$LSSTTS_DDS_VERSION
