export OSPL_VERSION=6.9.0
export LSSTTS_SAL_VERSION=4.0.0
export LSSTTS_SALOBJ_VERSION=5.4.0
export LSSTTS_XML_VERSION=4.7.0
export LSSTTS_IDL_VERSION=1.1.0
export HEADERSERVICE_VERSION=1.4.1
export MINICONDA_PATH=/opt/miniconda3
export TAG=v${HEADERSERVICE_VERSION}_salobj_v${LSSTTS_SALOBJ_VERSION}_xml_v${LSSTTS_XML_VERSION}
export CCS_IDL_LIST="EFD ATHeaderService ATCamera ATArchiver ATPtg ATMCS ATSpectrograph ATTCS ATHexapod ATDome DIMM CCCamera CCArchiver CCHeaderService Environment"
docker-compose build salrun salidl salobj headerservice
