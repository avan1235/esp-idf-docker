FROM debian:bookworm-slim

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update  \
    && apt install -y  \
        ssh \
        build-essential \
        gcc \
        g++ \
        gdb \
        clang \
        make \
        ninja-build \
        cmake \
        autoconf \
        automake \
        libtool \
        valgrind \
        locales-all \
        dos2unix \
        rsync \
        tar \
        apt-utils \
        bison \
        ca-certificates \
        ccache \
        check \
        cmake  \
        curl \
        dfu-util \
        flex \
        git \
        git-lfs \
        gperf \
        lcov \
        libbsd-dev \
        libffi-dev \
        libncurses-dev \
        libssl-dev  \
        libusb-1.0-0-dev \
        make \
        ninja-build \
        python3 \
        python3-venv \
        python3-pip \
        ruby \
        unzip \
        wget \
        xz-utils \
        zip \
    && apt autoremove -y \
    && rm -rf /var/lib/apt/lists/* \
    && update-alternatives --install /usr/bin/python python /usr/bin/python3 10

RUN cd /opt && \
    git clone --recursive https://github.com/espressif/esp-idf.git

RUN cd /opt/esp-idf && git submodule update --init --recursive && ./install.sh all

RUN echo "if [ -f /root/.bashrc ]; then source /root/.bashrc; fi" >> /root/.bash_profile
RUN echo "export IDF_PATH=/opt/esp-idf" >> /root/.bashrc
RUN echo "export PATH=/opt/esp-idf/components/esptool_py/esptool:/opt/esp-idf/components/espcoredump:/opt/esp-idf/components/partition_table:/opt/esp-idf/components/app_update:/root/.espressif/tools/xtensa-esp-elf-gdb/$(ls /root/.espressif/tools/xtensa-esp-elf-gdb/)/xtensa-esp-elf-gdb/bin:/root/.espressif/tools/riscv32-esp-elf-gdb/$(ls /root/.espressif/tools/riscv32-esp-elf-gdb/)/riscv32-esp-elf-gdb/bin:/root/.espressif/tools/xtensa-esp32-elf/$(ls /root/.espressif/tools/xtensa-esp32-elf/)/xtensa-esp32-elf/bin:/root/.espressif/tools/xtensa-esp32s2-elf/$(ls /root/.espressif/tools/xtensa-esp32s2-elf/)/xtensa-esp32s2-elf/bin:/root/.espressif/tools/xtensa-esp32s3-elf/$(ls /root/.espressif/tools/xtensa-esp32s3-elf/)/xtensa-esp32s3-elf/bin:/root/.espressif/tools/riscv32-esp-elf/$(ls /root/.espressif/tools/riscv32-esp-elf/)/riscv32-esp-elf/bin:/root/.espressif/tools/esp32ulp-elf/$(ls /root/.espressif/tools/esp32ulp-elf/)/esp32ulp-elf/bin:/root/.espressif/tools/openocd-esp32/$(ls /root/.espressif/tools/openocd-esp32/)/openocd-esp32/bin:/root/.espressif/python_env/$(ls /root/.espressif/python_env/)/bin:/opt/esp-idf/tools:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin" >> /root/.bashrc

RUN cd /opt/esp-idf/components && git clone --recursive https://github.com/espressif/esp32-camera.git

RUN ( \
    echo 'LogLevel DEBUG2'; \
    echo 'PermitRootLogin yes'; \
    echo 'PasswordAuthentication yes'; \
    echo 'Subsystem sftp /usr/lib/openssh/sftp-server'; \
  ) > /etc/ssh/sshd_config_esp_idf \
  && mkdir /run/sshd

RUN yes password | passwd root

CMD ["/usr/sbin/sshd", "-D", "-e", "-f", "/etc/ssh/sshd_config_esp_idf"]