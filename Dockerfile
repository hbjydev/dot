FROM quay.io/fedora/fedora:36

RUN adduser -m -u 1000 -G wheel hayden && sed -i /etc/sudoers -re 's/^%wheel.*/%wheel ALL=(ALL:ALL) NOPASSWD: ALL/g'

USER 1000
WORKDIR /home/hayden

COPY --chown=1000 . /home/hayden/.local/share/dotfiles

RUN bash /home/hayden/.local/share/dotfiles/bin/dotfiles

ENTRYPOINT [ "/usr/bin/bash" ]

