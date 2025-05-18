# Set the architecture and download the root filesystem
VERSION=2024091801
BASE_URL=https://kali.download/nethunter-images/current/rootfs
SYS_ARCH=$(getprop ro.product.cpu.abi)

IMAGE_NAME=kali-nethunter-rootfs-full-arm64.tar.xz

# Download the root filesystem
wget "${BASE_URL}/${IMAGE_NAME}"

# Extract the root filesystem
proot --link2symlink tar -xf "$IMAGE_NAME"

# Create a launcher for NetHunter
cat > "$PREFIX/bin/nethunter" <<- EOF
#!/data/data/com.termux/files/usr/bin/bash -e
cd \$HOME
proot --link2symlink -0 -r kali-${SYS_ARCH} -b /dev -b /proc -b /sdcard /usr/bin/env -i HOME=\$HOME PATH=/usr/local/sbin:/usr/local/bin:/bin:/usr/bin:/sbin:/usr/sbin /bin/bash --login
EOF

chmod +x "$PREFIX/bin/nethunter"

# Print success message
echo "Kali NetHunter installed successfully. Use 'nethunter' to start."