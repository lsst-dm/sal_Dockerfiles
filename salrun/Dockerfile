FROM centos:7

ARG MINICONDA_PATH

LABEL name="LSST SAL Runtime Dependencies" \
    vendor="LSST" \
    license="GPLv3"

RUN yum -y install epel-release
RUN yum -y install python36 python36-devel python36-pip \
    git make patch wget \
    gcc-c++

# Conda installation for Py37
RUN mkdir -p ${MINICONDA_PATH} \
    && cd ${MINOCONDA_PATH} \
    && wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    && chmod +x Miniconda3-latest-Linux-x86_64.sh \
    && ./Miniconda3-latest-Linux-x86_64.sh -b -p ${MINICONDA_PATH} -u

# Start the env and add channels
RUN source $MINICONDA_PATH/bin/activate \
    && conda config --add channels conda-forge

# Pre-reqs for salobj/dds
RUN source ${MINICONDA_PATH}/bin/activate \
   && conda install -y pyyaml setuptools==41.0.1 jsonschema==3.0.1 Cython==0.29.12 boto3==1.11.14  moto=1.3.14

COPY lsst-ts-nexus.repo /etc/yum.repos.d
COPY setup_SAL.env /opt/lsst/setup_SAL.env

ARG OSPL_VERSION=6.9.0

RUN yum -y install OpenSpliceDDS-$OSPL_VERSION

ENV OSPL_HOME /opt/OpenSpliceDDS/V${OSPL_VERSION}/HDE/x86_64.linux

# Install python dds from the OpenSplice rpms files
RUN source ${MINICONDA_PATH}/bin/activate \
    && source /opt/lsst/setup_SAL.env \
    && cd $OSPL_HOME/tools/python/src \
    && python3 setup.py install
