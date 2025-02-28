## Docker

- Install docker

  - `sudo pacman -S docker`

- Start docker service

  - `sudo systemctl start docker.service`

- Verify

  - `sudo systemctl status docker.service`

- [Cred management](https://docs.docker.com/desktop/get-started/#credentials-management-for-linux-users)
  - `gpg --generate-key`
  - `gpg --list-secret-keys --keyid-format=long`

# Todo after installing Linux

> I wrote this a long time ago. Need to revisit this if it's relevant for my setup

- If using pulse audio, edit `/etc/pulse/default.pa`

  - Comment out the following:

    - `load-module module-switch-on-port-available`

    - `load-module module-switch-on-connect`

  - Add the desired default sink and source:

    - `set-default-sink output-device`

    - `set-default-source input-device`
