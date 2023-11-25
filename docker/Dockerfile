FROM espressif/idf:latest

RUN : \
  && apt-get update \
  && apt-get install -y \
    apt-utils \
    autoconf \
    automake \
    bison \
    build-essential \
    bzip2 \
    ca-certificates \
    ccache \
    check \
    clang \
    cmake \
    cmake  \
    curl \
    dfu-util \
    dos2unix \
    flex \
    g++ \
    gcc \
    gdb \
    git \
    git-lfs \
    gperf \
    lcov \
    libbsd-dev \
    libffi-dev \
    libglib2.0-0 \
    libncurses-dev \
    libpixman-1-0 \
    libslirp0 \
    libssl-dev  \
    libtool \
    libusb-1.0-0-dev \
    locales-all \
    make \
    ninja-build \
    openssh-server \
    python3 \
    python3-pip \
    python3-venv \
    rsync \
    ruby \
    ssh \
    tar \
    unzip \
    valgrind \
    wget \
    xz-utils \
    zip \
  && apt-get autoremove -y \
  && rm -rf /var/lib/apt/lists/* \
  && update-alternatives --install /usr/bin/python python /usr/bin/python3 10 \
  && :

RUN ( \
    echo 'LogLevel DEBUG2'; \
    echo 'PermitRootLogin yes'; \
    echo 'PermitUserEnvironment yes'; \
    echo 'PasswordAuthentication yes'; \
    echo 'Subsystem sftp /usr/lib/openssh/sftp-server'; \
  ) > /etc/ssh/sshd_config_esp_idf \
  && mkdir /run/sshd

RUN yes password | passwd root

ARG IDF_TARGET

RUN echo "if [ -f /root/.bashrc ]; then source /root/.bashrc; fi" >> /root/.bash_profile
RUN echo "export IDF_PATH=/opt/esp/idf" >> /root/.bashrc
RUN echo "export IDF_TOOLS_PATH=/opt/esp" >> /root/.bashrc
RUN echo "export IDF_TARGET=${IDF_TARGET}" >> /root/.bashrc

RUN mkdir -p /root/.ssh
RUN echo "IDF_PATH=/opt/esp/idf" >> /root/.ssh/environment
RUN echo "IDF_TOOLS_PATH=/opt/esp" >> /root/.ssh/environment
RUN echo "IDF_TARGET=${IDF_TARGET}" >> /root/.ssh/environment

COPY set-path.sh /opt/esp/set-path.sh
RUN /opt/esp/set-path.sh

RUN echo 'function idf() {\n    idf.py "$@"\n}' >> /root/.bashrc

COPY entrypoint.sh /opt/esp/entrypoint.sh
ENTRYPOINT [ "/opt/esp/entrypoint.sh" ]
CMD ["/usr/sbin/sshd", "-D", "-e", "-f", "/etc/ssh/sshd_config_esp_idf"]
