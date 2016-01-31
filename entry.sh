#!/bin/sh
gettarball() {
  mkdir -p /work/tarball
  cd /work/tarball;
  if [ ! -f src.tar.gz ]; then 
	  wget ${FTPURL}/tar_files/src.tar.gz
  fi
  if [ ! -f xsrc.tar.gz ]; then 
	  wget ${FTPURL}/tar_files/xsrc.tar.gz
  fi
}

extractsrc() {
  tar zxf /work/tarball/src.tar.gz -C /source/
  tar zxf /work/tarball/xsrc.tar.gz -C /source/
}

DATE=`date +%Y%m%d`
FTPURL=${FTPURL-ftp://ftp.netbsd.org/pub/NetBSD/NetBSD-current}
JOBS=${JOBS-4}
if [ -n "$1" ]; then
if [ "$1" = 'shell' ]; then
  exec /bin/sh
else
  ARCH=$1
  if [ ! -e /source/src/build.sh ]; then
	  gettarball
	  extractsrc
  fi
  cd /source/src && \
  exec ./build.sh -m ${ARCH} -U -u -x -V RELEASEMACHINEDIR=${ARCH} \
  -j ${JOBS} -X /source/xsrc -T /work/tools -O /work/obj \
  -D /work/dest -R /release/${DATE}/ release iso-image
fi
else
  echo "Usage: docker run [-e FTPURL={ftp://any.where.domain/pub/NetBSD/NetBSD-current}] [-e JOBS={n}] [-v {whresource}:/source] [-v {OUTPUT_RELEASE}:/release] netbsd-builder {arch}"
  exit 1
fi
