non official image for building TIC-80 for Android

build image:
```bash
$ docker build . -t tic-builder
```

build TIC-80:
```
$ mkdir build
$ docker run --rm -v `pwd`/build:/home/root/TIC-80/build/android/app/build tic-builder ./gradlew assembleRelease
```

APK will be saved in `build/outputs/apk/release`
