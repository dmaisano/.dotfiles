## Docker

- Install docker
    - `sudo pacman -S docker`

- Start docker service
    - `sudo systemctl start docker.service`

- Verify
    - `sudo systemctl status docker.service `

- [Cred management](https://docs.docker.com/desktop/get-started/#credentials-management-for-linux-users)
    - `gpg --generate-key`
    -  `gpg --list-secret-keys --keyid-format=long`