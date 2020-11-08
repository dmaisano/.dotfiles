# coolbits

To enable GPU fan control set _Coolbits_ value **4**

```
# /etc/X11/org.conf

Section "Device"
    Identifier     "Device0"
    Driver         "nvidia"
    VendorName     "NVIDIA Corporation"
    Option		   "Coolbits" "12" # fan control + overclocking enabled
EndSection
```

> reference: https://wiki.archlinux.org/index.php/NVIDIA/Tips_and_tricks#Overclocking_and_cooling
