#!/bin/bash

# Show some documentation
cat <<EOF
Welcome to the Parch Linux WSL image!

This image is maintained at <https://git.parchlinux.com/parchlinux/parchlinux-wsl>.

Please, report bugs at <https://git.parchlinux.org/parchlinux/parchlinux-wsl/-/issues>.
Note that WSL 1 is not supported.

For more information about this WSL image and its usage (including "tips and tricks" and troubleshooting steps), see the related Arch Wiki page at <https://wiki.parchlinux.com/title/Install_Parch_Linux_on_WSL>.

While images are built regularly, it is strongly recommended running "pacman -Syu" right after the first launch due to the rolling release nature of Parch Linux.
EOF

echo -e "\nGenerating pacman keys..." && pacman-key --init 2> /dev/null && echo "Done"