- Результирующий файл конфигурации

[.config](lect-1/.config)
- Список доустановленных пакетов
````
yum install gcc
yum install bc
yum install openssl-devel
yum install perl
````
- весь процесс установки
````
cd /usr/src/kernels/
sudo curl -O https://cdn.kernel.org/pub/linux/kernel/v4.x/linux-4.9.176.tar.xz
sudo tar -xJf linux-4.9.176.tar.xz 
cd linux-4.9.176/
sudo -s
cp /boot/config-3.10.0-957.5.1.el7.x86_64 .config
make olddefconfig
yum install gcc
make olddefconfig
yum install bc
yum install openssl-devel
yum install perl
make
make modules_install
make install
sudo grub2-reboot 0 ## change only for first boot
sudo reboot
uname -r ## 4.9.176 
````