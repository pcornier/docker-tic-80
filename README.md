non official image for building TIC-80 for Android

```bash
$ docker build . -t tic-builder
$ mkdir build
$ docker run --rm -v `pwd`/build:/home/root/TIC-80/build/android/app/build tic-builder ./gradlew assembleRelease
```
