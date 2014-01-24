virtualmin-chruby-passenger-installer
================================

get install.sh

```
wget https://raw.github.com/devotg/virtualmin-chruby-passenger-installer/master/install.sh
sh install.sh
rm install.sh
```

vps testing

```
wget freevps.us/downloads/bench.sh -O - -o /dev/null|bash
df -h
free -m
dd if=/dev/zero of=test bs=64k count=16k conv=fdatasync
hostname -f
```
