# stands-03-lvm

Стенд для домашнего занятия "Файловые системы и LVM"

**Домашнее задание**

Работа с LVM
на имеющемся образе 
/dev/mapper/VolGroup00-LogVol00 38G 738M 37G 2% /

уменьшить том под / до 8G
выделить том под /home
выделить том под /var
/var - сделать в mirror
/home - сделать том для снэпшотов
прописать монтирование в fstab
попробовать с разными опциями и разными файловыми системами ( на выбор)
- сгенерить файлы в /home/
- снять снэпшот
- удалить часть файлов
- восстановится со снэпшота
- залоггировать работу можно с помощью утилиты script

* на нашей куче дисков попробовать поставить btrfs/zfs - с кешем, снэпшотами - разметить здесь каталог /opt
Критерии оценки: основная часть обязательна
задание со звездочкой +1 балл


**Уменьшить том и сделать /var в mirror**

[hw3_1.cast](./hw3_1.cast)

[![asciicast](https://asciinema.org/a/lH0MRPtGMjpJa4qckRlto0vjI.svg)](https://asciinema.org/a/lH0MRPtGMjpJa4qckRlto0vjI)

**/home - сделать том для снэпшотов**

[hw3_2.cast](./hw3_2.cast)

[![asciicast](https://asciinema.org/a/mysZOLJsLAHHxh9TyvQTtFsJY.svg)](https://asciinema.org/a/mysZOLJsLAHHxh9TyvQTtFsJY)

**zfs /opt with cache and snapshot**

[hw3_3.cast](./hw3_3.cast)

[![asciicast](https://asciinema.org/a/a7uYrZNLLMq6NNqzNS30iZZIe.svg)](https://asciinema.org/a/a7uYrZNLLMq6NNqzNS30iZZIe)