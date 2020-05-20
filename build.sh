export OSPL_VERSION=6.9.0
# export LSSTTS_SAL_VERSION=4.1.2_408 -- For dailys
export LSSTTS_SAL_VERSION=4.1.2
export LSSTTS_XML_VERSION=5.1.0
export LSSTTS_SALOBJ_VERSION=5.11.0
export LSSTTS_IDL_VERSION=1.2.0
export HEADERSERVICE_VERSION=2.2.0
export MINICONDA_PATH=/opt/miniconda3
export TAG=v${HEADERSERVICE_VERSION}_salobj_v${LSSTTS_SALOBJ_VERSION}_xml_v${LSSTTS_XML_VERSION}
export CCS_IDL_LIST="ATHeaderService ATCamera ATArchiver ATPtg MTPtg ATMCS ATSpectrograph ATHexapod ATAOS Hexapod ATDome DIMM CCCamera CCArchiver CCHeaderService Environment"
docker-compose build salrun salidl salobj headerservice
