# https://github.com/karakun/OpenWebStart/releases/download/v1.11.0/OpenWebStart_linux_1_11_0.deb
FROM debian:bullseye

ENV TZ=Europe/Amsterdam
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ > /etc/timezone


RUN apt-get update && apt-get install -y curl 

RUN curl -LO https://github.com/karakun/OpenWebStart/releases/download/v1.11.0/OpenWebStart_linux_1_11_0.deb

RUN apt-get update \
    && apt-get install -y ./OpenWebStart_linux_1_11_0.deb \
    && apt-get clean

# Parameters for default user:group
ARG uid=1000
ARG user=sportlink
ARG gid=1000
ARG group=sportlink

# Add or modify user and group for build and runtime (convenient)
RUN id ${user} > /dev/null 2>&1 \
    && { groupmod -g "${gid}" "${group}" && usermod -md /home/${user} -s /bin/bash -g "${group}" -u "${uid}" "${user}"; } \
    || { groupadd -g "${gid}" "${group}" && useradd -md /home/${user} -s /bin/bash -g "${group}" -u "${uid}" "${user}"; }


# Switch to non-root user
USER ${user}
WORKDIR /home/${user}

CMD javaws https://club.sportlink.com/apps/club-production/knvb.jnlp
