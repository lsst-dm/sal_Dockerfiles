FROM centos:7

LABEL name="LSST SAL Runtime Dependencies" \
    vendor="LSST" \
    license="GPLv3"

RUN yum -y install epel-release
RUN yum -y install python36 python36-pip git
RUN pip3.6 install --upgrade pip
RUN pip3 install pyyaml setuptools==41.0.1 jsonschema==3.0.1 Cython==0.29.12

COPY lsst-ts.repo /etc/yum.repos.d
COPY setup_SAL.env /opt/lsst/setup_SAL.env

ARG OSPL_VERSION=6.9.0

RUN yum -y install OpenSpliceDDS-$OSPL_VERSION

ENV OSPL_HOME /opt/OpenSpliceDDS/V${OSPL_VERSION}/HDE/x86_64.linux
