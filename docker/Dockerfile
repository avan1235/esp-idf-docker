FROM espressif/idf:latest

RUN : \
  && apt-get update \
  && apt-get install -y \
    openssh-server \
  && apt-get autoremove -y \
  && rm -rf /var/lib/apt/lists/* \
  && :

RUN ( \
    echo 'LogLevel DEBUG2'; \
    echo 'PermitRootLogin yes'; \
    echo 'PasswordAuthentication yes'; \
    echo 'Subsystem sftp /usr/lib/openssh/sftp-server'; \
  ) > /etc/ssh/sshd_config_esp_idf \
  && mkdir /run/sshd

RUN yes password | passwd root

COPY entrypoint.sh /opt/esp/entrypoint.sh
ENTRYPOINT [ "/opt/esp/entrypoint.sh" ]
CMD ["/usr/sbin/sshd", "-D", "-e", "-f", "/etc/ssh/sshd_config_esp_idf"]
