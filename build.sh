export OSPL_VERSION=6.10.4
export OSPL_RPM_VERSION=6.10.4-6.el7
export LSSTTS_DDS_VERSION=6.10.4_6
export LSSTTS_SAL_VERSION=5.0.1
export LSSTTS_XML_VERSION=7.1.0
export LSSTTS_SALOBJ_VERSION=6.2.0
export LSSTTS_IDL_VERSION=2.3.0
export LSSTTS_DDSCONFIG_VERSION=v0.5.1
export LSSTTS_IDL_CONDA_VERSION=${LSSTTS_IDL_VERSION}_${LSSTTS_XML_VERSION}_${LSSTTS_SAL_VERSION}
export HEADERSERVICE_VERSION=2.6.0
export MINICONDA_PATH=/opt/miniconda3

export TAG_TS=v${HEADERSERVICE_VERSION}_salobj_v${LSSTTS_SALOBJ_VERSION}_idl_v${LSSTTS_SALIDL_VERSION}_xml_v${LSSTTS_XML_VERSION}
export TAG_DM=${LSSTTS_SAL_VERSION}-${LSSTTS_XML_VERSION}-salobj_${LSSTTS_SALOBJ_VERSION}-hs_${HEADERSERVICE_VERSION}
export TAG=v${HEADERSERVICE_VERSION}_salobj_v${LSSTTS_SALOBJ_VERSION}_xml_v${LSSTTS_XML_VERSION}
docker-compose build salrun salidl salobj headerservice

echo "Re-taggins as:"
echo "               ts-dockerhub.lsst.org/headerservice:dm-${TAG_TS}"
echo "docker tag lsstdm/headerservice:${TAG_DM} ts-dockerhub.lsst.org/headerservice:dm-${TAG_TS}"
docker tag lsstdm/headerservice:${TAG_DM} ts-dockerhub.lsst.org/headerservice:dm-${TAG_TS}
