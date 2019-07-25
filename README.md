# Docker Environment for OpenSplice/SAL/salobj

To create the images:
```
export IMAGE_TAG=sal_3.10.0_salobj_4.10
docker-compose build --no-cache salbase salrpm salsrc salobj 
```
