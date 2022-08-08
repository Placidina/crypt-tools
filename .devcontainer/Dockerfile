FROM golang:1.19

SHELL ["/bin/bash", "-c"]

ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=${USER_UID}
ARG SSH_PASSWD

ENV SSH_PASSWD=${SSH_PASSWD} \
    USERNAME=${USERNAME} \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8 \
    DEBIAN_FRONTEND=noninteractive

RUN set -eux \
    && apt-get update \
    && apt-get install -y \
    sudo \
    vim

RUN set -eux \
    && useradd --uid ${USER_UID} -m -s /bin/bash ${USERNAME}

RUN mkdir -p /go/src/github.com/Placidina/crypt-tools \
    /commandhistory \
    /home/${USERNAME}/.ssh \
    /home/${USERNAME}/.ssh-localhost \
    /home/${USERNAME}/.vscode-server \
    /home/${USERNAME}/.vscode-server-insiders \
    /home/${USERNAME}/.cache/go-build \
    /home/${USERNAME}/.cache/golangci-lint \
    && chown -R ${USERNAME}:${USERNAME} /home/${USERNAME} /go \
    && chmod 777 -R /home/${USERNAME} /go/src/github.com/Placidina/crypt-tools \
    && chmod 700 /home/${USERNAME}/.ssh \
    && touch /commandhistory/.bash_history \
    && chown -R ${USERNAME} /commandhistory \
    && echo ${USERNAME} ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/${USERNAME} \
    && chmod 0440 /etc/sudoers.d/${USERNAME} \
    && echo "set -o history" >> "/home/${USERNAME}/.bashrc" \
    && echo "export HISTCONTROL=ignoredups:erasedups" >> "/home/${USERNAME}/.bashrc" \
    && echo "PROMPT_COMMAND=\"${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r\"" >> "/home/${USERNAME}/.bashrc"

USER ${USERNAME}

COPY scripts/sshd_config /home/${USERNAME}/.ssh/sshd_config

RUN set -eux \
    && ssh-keygen -q -N "" -t ecdsa -b 521 -f /home/${USERNAME}/.ssh/ssh_host_ecdsa_key

WORKDIR /go/src/github.com/Placidina/crypt-tools