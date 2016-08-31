FROM ubuntu:xenial

RUN apt-get update
RUN apt-get install -yq sudo curl wget git file g++ cmake pkg-config \
                        libasound2-dev bison flex mingw-w64 unzip ant openjdk-8-jdk

RUN curl https://sh.rustup.rs -sSf | sh -s -- -y
ENV PATH /root/.cargo/bin:$PATH
RUN /root/.cargo/bin/rustup default nightly
RUN /root/.cargo/bin/rustup target add arm-linux-androideabi
RUN cargo install cargo-apk

RUN curl -L https://dl.google.com/android/android-sdk_r24.4.1-linux.tgz | tar xz -C /usr/local
ENV ANDROID_HOME /usr/local/android-sdk-linux
RUN echo y | ${ANDROID_HOME}/tools/android update sdk --no-ui --all --filter platform-tools,android-18
ENV PATH $PATH:${ANDROID_HOME}/tools:$ANDROID_HOME/platform-tools

RUN curl -L https://dl.google.com/android/repository/android-ndk-r12b-linux-x86_64.zip | tar xz -C /usr/local
ENV NDK_HOME /usr/local/android-ndk-r12b
