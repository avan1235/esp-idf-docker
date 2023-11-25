#!/bin/bash

PS3="Select default idf target: "
options=("esp32" "esp32s2" "esp32c3" "esp32s3" "esp32c2" "esp32c6" "esp32h2" "linux" "esp32p4")

select choice in "${options[@]}"; do
    case $REPLY in
        1) IDF_TARGET="esp32"; break ;;
        2) IDF_TARGET="esp32s2"; break ;;
        3) IDF_TARGET="esp32c3"; break ;;
        4) IDF_TARGET="esp32s3"; break ;;
        5) IDF_TARGET="esp32c2"; break ;;
        6) IDF_TARGET="esp32c6"; break ;;
        7) IDF_TARGET="esp32h2"; break ;;
        8) IDF_TARGET="linux"; break ;;
        9) IDF_TARGET="esp32p4"; break ;;
        *) echo "Invalid option. Please try again." ;;
    esac
done

CONTAINER_NAME="esp_idf_ssh"
IMAGE_TAG="avan1235/esp-idf-${IDF_TARGET}-ssh:latest"

ssh-keygen -f "$HOME/.ssh/known_hosts" -R "[localhost]:2222"
ssh-keygen -f "$HOME/.ssh/known_hosts" -R "[127.0.0.1]:2222"

docker stop "${CONTAINER_NAME}"
docker rm "${CONTAINER_NAME}"
if [[ "$*" == *"--no-device"* ]]
then
    docker run -d --cap-add sys_ptrace -p 127.0.0.1:2222:22 --name "${CONTAINER_NAME}" "${IMAGE_TAG}"
else
    docker run -d --cap-add sys_ptrace -p 127.0.0.1:2222:22 --device=/dev/ttyACM1 --name "${CONTAINER_NAME}" "${IMAGE_TAG}"
fi
