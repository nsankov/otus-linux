
- RAID10
````
lshw -short
mdadm --zero-superblock --force /dev/sd{b,c,d,e,f} #зануляем суперблоки если осталось от предыдушего рейда
mdadm --create --verbose /dev/md0 -l 10 -n 5 /dev/sd{b,c,d,e,f} #raid-10 5 дисков
````

````
cat /proc/mdstat 
Personalities : [raid10] 
md0 : active raid10 sdf[4] sde[3] sdd[2] sdc[1] sdb[0]
      13094400 blocks super 1.2 512K chunks 2 near-copies [5/5] [UUUUU]
      [==============>......]  resync = 73.4% (9617408/13094400) finish=0.2min speed=200576K/sec

````

````
mdadm --detail --scan --verbose
ARRAY /dev/md0 level=raid10 num-devices=5 metadata=1.2 name=otuslinux:0 UUID=e74dfa35:7bf4a5be:9518cd2b:7975bf88
   devices=/dev/sdb,/dev/sdc,/dev/sdd,/dev/sde,/dev/sdf
````

добавим диск для четности
````
mdadm --zero-superblock --force /dev/sdg
mdadm /dev/md0 --add /dev/sdg
cat /proc/mdstat # check add
mdadm -G /dev/md0 --raid-devices=6 ##расширяем массив и указываем новое кол-во дисков
````

зафейлим диск и заменим
````

mdadm /dev/md0 --fail  /dev/sdg
mdadm /dev/md0 --remove /dev/sdg
mdadm /dev/md0 --add /dev/sdg
````

````
cat /proc/mdstat 
Personalities : [raid10] 
md0 : active raid10 sdg[6] sdf[4] sde[3] sdd[2] sdc[1] sdb[0]
      15713280 blocks super 1.2 512K chunks 2 near-copies [6/5] [UUUUU_]
      [==========>..........]  recovery = 50.4% (2640512/5237760) finish=1.2min speed=33676K/sec
      
unused devices: <none>
````

- GPT
````
parted -s /dev/md0 mklabel gpt


parted /dev/md0 mkpart primary ext4 0% 20%
parted /dev/md0 mkpart primary ext4 20% 40%
parted /dev/md0 mkpart primary ext4 40% 60%
parted /dev/md0 mkpart primary ext4 60% 80%
parted /dev/md0 mkpart primary ext4 80% 100%

for i in $(seq 1 5); do sudo mkfs.ext4 /dev/md0p$i; done
ls /dev/md0*
mkdir -p /raid/part{1,2,3,4,5}
for i in $(seq 1 5); do mount /dev/md0p$i /raid/part$i; done
````