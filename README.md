# box-setup

```bash
curl -H 'Cache-Control: no-cache' -s https://raw.githubusercontent.com/wspecs/box-setup/master/build.sh | sudo -E bash
```

# set up a database box

This set up is to install a mysql group on multiple instances.

```bash
cd ~
bash
curl -H 'Cache-Control: no-cache' -s https://raw.githubusercontent.com/wspecs/box-setup/master/database.sh -o build.sh
chmod +x build.sh
export DATABASE_SERVERS="10.108.0.2 10.108.0.3 10.108.0.4"
export GROUP_PASSWORD="change-me"
export UNIQUE_ID=0ce4aada-7966-4e0d-bf7d-4484f16f6fe3
./build.sh
rm build.sh
```

# hello box

```bash
curl -H 'Cache-Control: no-cache' -s https://raw.githubusercontent.com/wspecs/box-setup/master/hello.sh | sudo -E bash
```
