export OSPL_VERSION=6.9.0
export LSSTTS_SAL_VERSION=4.0.0
export LSSTTS_SALOBJ_VERSION=5.0.0
export LSSTTS_XML_VERSION=4.6.0
export LSSTTS_IDL_VERSION=1.0.0
export HEADERSERVICE_VERSION=1.3.1
export CCS_IDL_LIST="EFD ATHeaderService ATCamera ATArchiver ATPtg ATMCS ATSpectrograph ATTCS ATHexapod"
docker-compose build salrun salidl salobj atheaderservice
