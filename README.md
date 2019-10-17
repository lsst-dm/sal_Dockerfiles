# Docker Environment for CSC using OpenSplice/SAL/salobj

To create the images:
```
export OSPL_VERSION=6.9.0
export LSSTTS_SAL_VERSION=3.10.0
export LSSTTS_SALOBJ_VERSION=4.5.0
export LSSTTS_XML_VERSION=4.2.0
export LSSTTS_IDL_VERSION=0.2.0
export HEADERSERVICE_VERSION=1.1.0
export SALPYTOOLS_VERSION=0.9.7
export CCS_IDL_LIST="EFD ATHeaderService ATCamera ATArchiver ATPtg ATMCS ATSpectrograph ATTCS ATHexapod"
docker-compose build --no-cache

```
