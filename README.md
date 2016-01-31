# netbsd-builder
Dockerfile for building NetBSD release binary
## Create docker image
  docker build -t netbsd-builder .
## How to use
1. Prepare release directry to output on host (or remote, or another container,....)
2. Run container
  docekr run -v {WhereToOutputPath):/release netbsd-builder {archname}

## Option
### Local source volume
If you have local source tree on host, specify source volume.

    docker run -v {whereToSourcePath}:/source -v {WhereToOutputPath):/release netbsd-builder {archname}

For eexample, when src dir in /netbsd/src, specify '/netbsd' only.

## Environment variable
### FTPURL
  URL for getting the NetBSD source tar ball when not existing local sources.
  default is ftp://ftp.netbsd.org/pub/NetBSD/NetBSD-current
### JOBS
njobs for build.sh -j number

## Examples
for build NetBSD/x68k-current from FTP mirror. Redirect console logs to local file.

    docker run -t -e FTPURL=ftp://ftp2.jp.netbsd.org/pub/NetBSD/NetBSD-current \
    -v /release:/release netbsd-builder x68k > /home/mydir/buildlog 2>&1 &

## ToDo
- suport for src.tgz
- error check
- more...
