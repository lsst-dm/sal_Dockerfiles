export OSPL_VERSION=6.9.0
export LSSTTS_SAL_VERSION=4.1.4
export LSSTTS_XML_VERSION=6.1.0
export LSSTTS_SALOBJ_VERSION=5.17.0
export LSSTTS_IDL_VERSION=1.3.0
export HEADERSERVICE_VERSION=2.3.2
export MINICONDA_PATH=/opt/miniconda3
export TAG=v${HEADERSERVICE_VERSION}_salobj_v${LSSTTS_SALOBJ_VERSION}_xml_v${LSSTTS_XML_VERSION}
docker-compose build salrun salidl salobj headerservice
