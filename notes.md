# Todo after installing Linux

- If using pulse audio, edit `/etc/pulse/default.pa`

  - Comment out the following:

    - `load-module module-switch-on-port-available`

    - `load-module module-switch-on-connect`

  - Add the desired default sink and source:

    - `set-default-sink output-device`

    - `set-default-source input-device`
