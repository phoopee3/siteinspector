# Site Inspector

## Docker? One day, but not today, keep reading...

Edit the `docker-compose.yml` and add a random 30+ character SECRET_KEY_BASE value.

```sh
docker compose up -d
```

Go to url:  
http://localhost:808

## Actual instructions

Install ubuntu

Install stuff

bzip2

```bash
sudo apt install bzip2
```

git

```bash
sudo apt install -y git curl build-essential libssl-dev libreadline-dev zlib1g-dev
```

ruby

```bash
sudo apt install ruby-full build-essential zlib1g-dev
```

python

```bash
sudo apt install python3-distutils
```

wkhtmltopdf

```bash
sudo apt install wkhtmltopdf
```

clone siteinspector

```bash
git clone https://github.com/phoopee3/siteinspector.git
```

install rvm

```bash
sudo apt install rbenv ruby-build
```

update ruby to 3.1

```bash
rbenv install 3.1.0
```

set local version

```
rbenv local 3.1.0
```

install required files for something

```bash
sudo apt install libpq-dev
```

install dependencies

```bash
bundle install
```

set up node

```bash
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash - && sudo apt-get install -y nodejs
```

install yarn

```bash
sudo npm install -g yarn
```

install stuff using yarn

```bash
yarn install
```

install foreman

```bash
sudo apt install ruby-foreman
```

set up docker

```bash
sudo apt install docker.io docker-compose
```

```bash
sudo usermod -aG docker $USER && sudo systemcrl start docker
```

set up portainer

```bash
docker volume create portainer_data
```

```bash
docker run -d -p 9000:9000 -p 8000:8000   --name=portainer   --restart=always   -v /var/run/docker.sock:/var/run/docker.sock   -v portainer_data:/data   portainer/portainer-ce
```

```bash
docker compose up -d postgres redis
```