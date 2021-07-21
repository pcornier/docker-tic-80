FROM ubuntu:latest

WORKDIR /home/root

RUN apt update
RUN apt install git wget unzip apt-utils -y

RUN apt-get install -y locales
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=en_US.UTF-8

ENV LANG=en_US.UTF-8

RUN git clone --recursive https://github.com/nesbox/TIC-80
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get install openjdk-8-jdk -y

RUN wget https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip
RUN unzip sdk-tools-linux-4333796.zip
ENV PATH=/home/root/tools/bin:$PATH

RUN mkdir $HOME/.android && touch $HOME/.android/repositories.cfg

RUN yes | sdkmanager "platforms;android-26"
RUN yes | sdkmanager "build-tools;28.0.3"
RUN yes | sdkmanager --licenses

ENV ANDROID_HOME=/home/root/

RUN wget https://dl.google.com/android/repository/android-ndk-r18b-linux-x86_64.zip
RUN unzip android-ndk-r18b-linux-x86_64.zip
ENV ANDROID_NDK_HOME=/home/root/android-ndk-r18b

WORKDIR /home/root/TIC-80/build/android
RUN sed -i 's/-DBUILD_PRO=Off/-DBUILD_PRO=On/g' app/build.gradle

# $ docker build . -t tic-builder
# $ mkdir build
# $ docker run --rm -v `pwd`/build:/home/root/TIC-80/build/android/app/build tic-builder ./gradlew assembleRelease
