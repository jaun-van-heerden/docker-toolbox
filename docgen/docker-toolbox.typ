#set document(
  title: "Docker Toolbox - Complete Reference",
  author: "Docker Toolbox Contributors",
  date: auto,
)

#set page(
  paper: "a4",
  margin: (x: 1.5cm, y: 2cm),
  numbering: "1",
  header: align(right)[
    _Docker Toolbox - Complete Reference_
  ],
)

#set text(
  size: 11pt,
  hyphenate: true,
)

#set heading(numbering: "1.1")
#show heading.where(level: 1): set text(size: 24pt, weight: "bold")
#show heading.where(level: 2): set text(size: 18pt, weight: "bold")
#show heading.where(level: 3): set text(size: 14pt, weight: "semibold")

#show raw.where(block: true): block.with(
  fill: luma(240),
  inset: 10pt,
  radius: 4pt,
  width: 100%,
)

#show link: underline
#show link: set text(fill: rgb("#0066cc"))

#align(center)[
  #v(3cm)
  #text(size: 36pt, weight: "bold")[Docker Toolbox]
  #v(0.5cm)
  #text(size: 18pt)[Complete Reference Guide]
  #v(1cm)
  #text(size: 14pt)[
    71 Development Tools via Docker
  ]
  #v(0.5cm)
  #text(size: 12pt, style: "italic")[
    Run popular development tools without installing them locally
  ]
  #v(3cm)
  #text(size: 11pt)[
    Generated from tools.yaml
  ]
]

#pagebreak()

= Table of Contents

#outline(depth: 2, indent: 2em)

#pagebreak()

= Introduction

Docker Toolbox provides ready-to-use Docker commands for development tools across multiple categories. This reference guide contains all available tools with usage examples.

== Benefits

- *No local installation* required (just Docker)
- *Consistent behavior* across Linux, macOS, and Windows
- *Isolated environments* prevent conflicts
- *Easy to try* new tools without commitment
- *Clean uninstall* - just remove the container

#pagebreak()

= Categories Overview

#table(
  columns: (auto, 1fr, auto),
  stroke: 0.5pt,
  align: (left, left, right),
  [*Category*], [*Description*], [*Tools*],
  [Terminal Tools], [Command-line utilities and terminal enhancements], [11],
  [Programming Languages], [Language runtimes and interpreters], [5],
  [Development Environments & IDEs], [Complete development environments and IDEs], [7],
  [Static Site Generators], [Tools for building static websites], [3],
  [Build & Task Runners], [Task automation and build tools], [2],
  [Testing Tools], [Testing frameworks and tools], [1],
  [Databases], [Database servers and clients], [6],
  [Monitoring & Visualization], [Monitoring, metrics, and dashboards], [3],
  [Message Brokers & IoT], [MQTT, message queues, and IoT platforms], [1],
  [DevOps & Cloud CLI], [Cloud CLIs and infrastructure tools], [8],
  [Code Quality & Linting], [Code formatters and linters], [5],
  [Media & Documents], [Media processing and document conversion], [6],
  [Networking & Security], [Network tools and security scanners], [4],
  [Web Servers & Security], [Web servers and security tools], [2],
  [API Development], [API testing and development tools], [3],
  [Git Tools], [Git and version control tools], [2],
  [AI & Machine Learning], [AI models and machine learning tools], [2],
)

#pagebreak()

= Tools Reference

== Terminal Tools

=== Tmux

_Terminal multiplexer for managing multiple sessions_

*Docker Image:* `alpine`

*Usage:*

```bash
# Basic usage
docker run --rm -it -v ${PWD}:/workspace -v ~/.tmux.conf:/root/.tmux.conf -w /workspace alpine sh -c "apk add --no-cache tmux bash git && tmux"
```

*Aliases:*

Bash/Zsh: `dttmux`

#block(
  fill: rgb("#fffacd"),
  inset: 8pt,
  radius: 4pt,
)[
  *Note:* Container and tmux sessions are deleted when you exit. Mount your own `.tmux.conf` for custom settings.
]


=== Htop

_Interactive process viewer_

*Docker Image:* `alpine`

*Usage:*

```bash
# Basic usage
docker run --rm -it --pid=host alpine sh -c "apk add --no-cache htop && htop"
```

*Aliases:*

Bash/Zsh: `dthtop`


=== Lazygit

_Simple terminal UI for git commands_

*Docker Image:* `lazyteam/lazygit`

*Usage:*

```bash
# Basic usage
docker run --rm -it -v ${PWD}:/repo -w /repo lazyteam/lazygit
```

*Aliases:*

Bash/Zsh: `dtlazygit`


=== Lazydocker

_Simple terminal UI for Docker management_

*Docker Image:* `lazyteam/lazydocker`

*Usage:*

```bash
# Basic usage
docker run --rm -it -v /var/run/docker.sock:/var/run/docker.sock lazyteam/lazydocker
```

*Aliases:*

Bash/Zsh: `dtlazydocker`


=== Ripgrep

_Lightning-fast search tool (better than grep)_

*Docker Image:* `alpine`

*Usage:*

```bash
# Basic usage
docker run --rm -v ${PWD}:/data -w /data alpine sh -c "apk add --no-cache ripgrep > /dev/null 2>&1 && rg $args"
```

*Aliases:*

Bash/Zsh: `dtrg`


=== Fd

_Fast and user-friendly alternative to find_

*Docker Image:* `alpine`

*Usage:*

```bash
# Basic usage
docker run --rm -v ${PWD}:/data -w /data alpine sh -c "apk add --no-cache fd > /dev/null 2>&1 && fd $args"
```

*Aliases:*

Bash/Zsh: `dtfd`


=== Bat

_Cat clone with syntax highlighting_

*Docker Image:* `alpine`

*Usage:*

```bash
# Basic usage
docker run --rm -v ${PWD}:/data -w /data alpine sh -c "apk add --no-cache bat > /dev/null 2>&1 && bat $args"
```

*Aliases:*

Bash/Zsh: `dtbat`


=== Jq

_Lightweight JSON processor_

*Docker Image:* `ghcr.io/jqlang/jq`

*Usage:*

```bash
# Basic usage
docker run --rm -i ghcr.io/jqlang/jq $args
```

*Aliases:*

Bash/Zsh: `dtjq`


=== Yq

_YAML/JSON/XML processor (like jq for YAML)_

*Docker Image:* `mikefarah/yq`

*Usage:*

```bash
# Basic usage
docker run --rm -v ${PWD}:/workdir mikefarah/yq $args
```

*Aliases:*

Bash/Zsh: `dtyq`


#pagebreak()

== Programming Languages

=== Python

_Python 3.12 interpreter and runtime_

*Docker Image:* `python:3.12`

*Usage:*

```bash
# Basic usage
docker run --rm -it -v ${PWD}:/app -w /app python:3.12 python $args
```

```bash
# Ipython
docker run --rm -it -v ${PWD}:/app -w /app python:3.12 sh -c "pip install -q ipython && ipython"
```

*Aliases:*

Bash/Zsh: `dtpython`, `dtipython`

*Examples:*

- _Run Python script_
  ```bash
  dtpython script.py
  ```
- _Interactive Python shell_
  ```bash
  dtpython
  ```
- _IPython shell_
  ```bash
  dtipython
  ```


=== Node

_Node.js 22 runtime_

*Docker Image:* `node:22`

*Usage:*

```bash
# Basic usage
docker run --rm -it -v ${PWD}:/app -w /app node:22 node $args
```

```bash
# Npm
docker run --rm -v ${PWD}:/app -w /app node:22 npm $args
```

```bash
# Npx
docker run --rm -v ${PWD}:/app -w /app node:22 npx $args
```

```bash
# Yarn
docker run --rm -v ${PWD}:/app -w /app node:22 yarn $args
```

*Aliases:*

Bash/Zsh: `dtnode`, `dtnpm`, `dtnpx`


=== Go

_Go language compiler and runtime_

*Docker Image:* `golang:1.22`

*Usage:*

```bash
# Basic usage
docker run --rm -v ${PWD}:/app -w /app golang:1.22 go $args
```

*Aliases:*

Bash/Zsh: `dtgo`


=== Ruby

_Ruby interpreter_

*Docker Image:* `ruby:3.3`

*Usage:*

```bash
# Basic usage
docker run --rm -it -v ${PWD}:/app -w /app ruby:3.3 ruby $args
```

```bash
# Irb
docker run --rm -it -v ${PWD}:/app -w /app ruby:3.3 irb
```

```bash
# Bundle
docker run --rm -v ${PWD}:/app -w /app ruby:3.3 bundle $args
```

*Aliases:*

Bash/Zsh: `dtruby`, `dtirb`, `dtbundle`


=== Cargo

_Rust package manager and build tool_

*Docker Image:* `rust:latest`

*Usage:*

```bash
# Basic usage
docker run --rm -v ${PWD}:/app -v cargo-cache:/usr/local/cargo -w /app rust:latest cargo $args
```

```bash
# Rustc
docker run --rm -v ${PWD}:/app -w /app rust:latest rustc $args
```

*Aliases:*

Bash/Zsh: `dtcargo`, `dtrustc`

#block(
  fill: rgb("#fffacd"),
  inset: 8pt,
  radius: 4pt,
)[
  *Note:* The cargo-cache volume persists downloaded dependencies between runs.
]


#pagebreak()

== Development Environments & IDEs

=== Jupyter

_Jupyter Notebook for data science and analysis_

*Docker Image:* `jupyter/base-notebook`

*Usage:*

```bash
# Basic usage
docker run --rm -p 8888:8888 -v ${PWD}:/home/jovyan/work jupyter/base-notebook
```

```bash
# Jupyterlab
docker run --rm -p 8888:8888 -v ${PWD}:/home/jovyan/work jupyter/datascience-notebook
```

```bash
# Scipy
docker run --rm -p 8888:8888 -v ${PWD}:/home/jovyan/work jupyter/scipy-notebook
```

*Aliases:*

Bash/Zsh: `dtjupyter`, `dtjupyterlab`, `dtjupyterscipy`

#block(
  fill: rgb("#fffacd"),
  inset: 8pt,
  radius: 4pt,
)[
  *Note:* Access at http://localhost:8888. Copy the token from the logs.
]


=== Vscode

_VS Code Server in browser_

*Docker Image:* `codercom/code-server`

*Usage:*

```bash
# Basic usage
docker run --rm -p 8080:8080 -v ${PWD}:/home/coder/project codercom/code-server --auth none
```

*Aliases:*

Bash/Zsh: `dtvscode`

#block(
  fill: rgb("#fffacd"),
  inset: 8pt,
  radius: 4pt,
)[
  *Note:* Access at http://localhost:8080. No authentication by default.
]


=== Rstudio

_RStudio IDE for R programming_

*Docker Image:* `rocker/rstudio`

*Usage:*

```bash
# Basic usage
docker run --rm -p 8787:8787 -e PASSWORD=rstudio -v ${PWD}:/home/rstudio rocker/rstudio
```

```bash
# Tidyverse
docker run --rm -p 8787:8787 -e PASSWORD=rstudio -v ${PWD}:/home/rstudio rocker/tidyverse
```

*Aliases:*

Bash/Zsh: `dtrstudio`, `dtrstudiotidy`

#block(
  fill: rgb("#fffacd"),
  inset: 8pt,
  radius: 4pt,
)[
  *Note:* Access at http://localhost:8787. Login: rstudio / rstudio
]


=== Vert

_Web-based terminal and development environment_

*Docker Image:* `ghcr.io/vert-sh/vert:latest`

*Aliases:*

Bash/Zsh: `dtvert`, `dtvertstop`

#block(
  fill: rgb("#fffacd"),
  inset: 8pt,
  radius: 4pt,
)[
  *Note:* Supports multiple instances on different ports. Container persists between restarts.
]


=== Webtop

_Full Linux desktop environment in browser (no X11 needed)_

*Docker Image:* `lscr.io/linuxserver/webtop:ubuntu-mate`

*Usage:*

```bash
# Basic usage
docker run -d --name=webtop -p 3000:3000 -p 3001:3001 -v webtop-config:/config --shm-size="1gb" --restart unless-stopped lscr.io/linuxserver/webtop:ubuntu-mate
```

```bash
# Xfce
docker run -d --name=webtop -p 3000:3000 -p 3001:3001 -v webtop-config:/config --shm-size="1gb" --restart unless-stopped lscr.io/linuxserver/webtop:ubuntu-xfce
```

```bash
# Start
docker start webtop
```

```bash
# Stop
docker stop webtop
```

```bash
# Logs
docker logs webtop -f
```

*Aliases:*

Bash/Zsh: `dtwebtop`, `dtwebtopxfce`, `dtwebtopstart`

#block(
  fill: rgb("#fffacd"),
  inset: 8pt,
  radius: 4pt,
)[
  *Note:* Access at http://localhost:3000. Full Ubuntu desktop with Firefox, terminal, and file manager. Default password: abc
]


=== Nodered

_Flow-based programming for IoT and automation_

*Docker Image:* `nodered/node-red`

*Usage:*

```bash
# Basic usage
docker run --rm -p 1880:1880 -v nodered-data:/data nodered/node-red
```

```bash
# Start
docker start nodered
```

```bash
# Stop
docker stop nodered
```

```bash
# Logs
docker logs nodered -f
```

*Aliases:*

Bash/Zsh: `dtnodered`, `dtnoderedstart`, `dtnoderedstop`

#block(
  fill: rgb("#fffacd"),
  inset: 8pt,
  radius: 4pt,
)[
  *Note:* Access at http://localhost:1880. Flows stored in nodered-data volume.
]


=== N8N

_Workflow automation (Zapier/Make alternative)_

*Docker Image:* `n8nio/n8n`

*Usage:*

```bash
# Basic usage
docker run --rm -p 5678:5678 -v n8n-data:/home/node/.n8n n8nio/n8n
```

```bash
# Start
docker start n8n
```

```bash
# Stop
docker stop n8n
```

```bash
# Logs
docker logs n8n -f
```

*Aliases:*

Bash/Zsh: `dtn8n`, `dtn8nstart`, `dtn8nstop`

#block(
  fill: rgb("#fffacd"),
  inset: 8pt,
  radius: 4pt,
)[
  *Note:* Access at http://localhost:5678. Supports 200+ integrations.
]


#pagebreak()

== AI & Machine Learning

=== Ollama

_Run large language models locally (Llama, Mistral, etc)_

*Docker Image:* `ollama/ollama`

*Usage:*

```bash
# Start
docker run -d --restart unless-stopped -p 11434:11434 -v ollama-data:/root/.ollama --name ollama ollama/ollama
```

```bash
# Stop
docker stop ollama
```

```bash
# Exec
docker exec -it ollama ollama $args
```

```bash
# Run
docker exec -it ollama ollama run $args
```

```bash
# Pull
docker exec -it ollama ollama pull $args
```

```bash
# List
docker exec -it ollama ollama list
```

*Aliases:*

Bash/Zsh: `dtollama`, `dtollamastart`, `dtollamastop`

#block(
  fill: rgb("#fffacd"),
  inset: 8pt,
  radius: 4pt,
)[
  *Note:* Start server first, then pull models. API at http://localhost:11434
]


=== Openwebui

_ChatGPT-style web interface for Ollama_

*Docker Image:* `ghcr.io/open-webui/open-webui`

*Usage:*

```bash
# Basic usage
docker run -d --restart unless-stopped -p 3000:8080 -v open-webui-data:/app/backend/data --add-host=host.docker.internal:host-gateway --name open-webui ghcr.io/open-webui/open-webui
```

```bash
# Start
docker start open-webui
```

```bash
# Stop
docker stop open-webui
```

```bash
# Logs
docker logs open-webui -f
```

*Aliases:*

Bash/Zsh: `dtopenwebui`, `dtopenwebuistart`, `dtopenwebuistop`

#block(
  fill: rgb("#fffacd"),
  inset: 8pt,
  radius: 4pt,
)[
  *Note:* Access at http://localhost:3000. Requires Ollama running. First user to register becomes admin.
]


#pagebreak()

== Databases

=== Postgres

_PostgreSQL relational database_

*Docker Image:* `postgres:16`

*Usage:*

```bash
# Basic usage
docker run --rm -p 5432:5432 -e POSTGRES_PASSWORD=secret postgres:16
```

```bash
# Psql
docker run --rm -it postgres:16 psql $args
```

*Aliases:*

Bash/Zsh: `dtpostgres`, `dtpsql`


=== Mysql

_MySQL relational database_

*Docker Image:* `mysql:8`

*Usage:*

```bash
# Basic usage
docker run --rm -p 3306:3306 -e MYSQL_ROOT_PASSWORD=secret mysql:8
```

```bash
# Client
docker run --rm -it mysql:8 mysql $args
```

*Aliases:*

Bash/Zsh: `dtmysql`, `dtmysqlclient`


=== Redis

_Redis in-memory data store_

*Docker Image:* `redis:7-alpine`

*Usage:*

```bash
# Basic usage
docker run --rm -p 6379:6379 redis:7-alpine
```

```bash
# Cli
docker run --rm -it redis:7-alpine redis-cli $args
```

*Aliases:*

Bash/Zsh: `dtredis`, `dtrediscli`


=== Mongo

_MongoDB NoSQL document database_

*Docker Image:* `mongo:7`

*Usage:*

```bash
# Basic usage
docker run --rm -p 27017:27017 mongo:7
```

```bash
# Mongosh
docker run --rm -it mongo:7 mongosh $args
```

*Aliases:*

Bash/Zsh: `dtmongo`, `dtmongosh`


=== Influxdb

_Time-series database for IoT and metrics_

*Docker Image:* `influxdb:2`

*Usage:*

```bash
# Basic usage
docker run --rm -p 8086:8086 -v influxdb-data:/var/lib/influxdb2 influxdb:2
```

```bash
# Start
docker start influxdb
```

```bash
# Stop
docker stop influxdb
```

```bash
# Cli
docker exec -it influxdb influx
```

*Aliases:*

Bash/Zsh: `dtinfluxdb`, `dtinfluxstart`, `dtinfluxstop`

#block(
  fill: rgb("#fffacd"),
  inset: 8pt,
  radius: 4pt,
)[
  *Note:* Access UI at http://localhost:8086. Perfect for storing sensor data.
]


=== Nocodb

_Turn any database into a smart spreadsheet (Airtable alternative)_

*Docker Image:* `nocodb/nocodb`

*Usage:*

```bash
# Basic usage
docker run --rm -p 8080:8080 -v nocodb-data:/usr/app/data nocodb/nocodb
```

```bash
# Start
docker start nocodb
```

```bash
# Stop
docker stop nocodb
```

```bash
# Logs
docker logs nocodb -f
```

*Aliases:*

Bash/Zsh: `dtnocodb`, `dtnocodbstart`, `dtnocodbstop`

#block(
  fill: rgb("#fffacd"),
  inset: 8pt,
  radius: 4pt,
)[
  *Note:* Access at http://localhost:8080. Works with PostgreSQL, MySQL, SQLite.
]


#pagebreak()

== Monitoring & Visualization

=== Grafana

_Beautiful dashboards for metrics and time-series data_

*Docker Image:* `grafana/grafana`

*Usage:*

```bash
# Basic usage
docker run --rm -p 3000:3000 -v grafana-data:/var/lib/grafana grafana/grafana
```

```bash
# Start
docker start grafana
```

```bash
# Stop
docker stop grafana
```

```bash
# Logs
docker logs grafana -f
```

*Aliases:*

Bash/Zsh: `dtgrafana`, `dtgrafanastart`, `dtgrafanastop`

#block(
  fill: rgb("#fffacd"),
  inset: 8pt,
  radius: 4pt,
)[
  *Note:* Access at http://localhost:3000. Default login: admin/admin
]


=== Uptime-Kuma

_Self-hosted uptime monitoring with notifications_

*Docker Image:* `louislam/uptime-kuma`

*Usage:*

```bash
# Basic usage
docker run --rm -p 3001:3001 -v uptime-kuma-data:/app/data louislam/uptime-kuma
```

```bash
# Start
docker start uptime-kuma
```

```bash
# Stop
docker stop uptime-kuma
```

```bash
# Logs
docker logs uptime-kuma -f
```

*Aliases:*

Bash/Zsh: `dtuptime`, `dtuptimestart`, `dtuptimestop`

#block(
  fill: rgb("#fffacd"),
  inset: 8pt,
  radius: 4pt,
)[
  *Note:* Access at http://localhost:3001. Supports 50+ notification services.
]


=== Dozzle

_Real-time Docker container log viewer with web UI_

*Docker Image:* `amir20/dozzle`

*Usage:*

```bash
# Basic usage
docker run --rm -p 8080:8080 -v /var/run/docker.sock:/var/run/docker.sock:ro amir20/dozzle
```

```bash
# Start
docker start dozzle
```

```bash
# Stop
docker stop dozzle
```

*Aliases:*

Bash/Zsh: `dtdozzle`, `dtdozzlestart`, `dtdozzlestop`

#block(
  fill: rgb("#fffacd"),
  inset: 8pt,
  radius: 4pt,
)[
  *Note:* Access at http://localhost:8080. Zero configuration needed!
]


#pagebreak()

== DevOps & Cloud CLI

=== Localstack

_Local AWS cloud stack for testing (S3, Lambda, DynamoDB, etc)_

*Docker Image:* `localstack/localstack`

*Usage:*

```bash
# Basic usage
docker run --rm -p 4566:4566 -v localstack-data:/var/lib/localstack localstack/localstack
```

```bash
# Start
docker start localstack
```

```bash
# Stop
docker stop localstack
```

```bash
# Logs
docker logs localstack -f
```

*Aliases:*

Bash/Zsh: `dtlocalstack`, `dtlocalstackstart`, `dtlocalstackstop`

#block(
  fill: rgb("#fffacd"),
  inset: 8pt,
  radius: 4pt,
)[
  *Note:* All services at http://localhost:4566. Use AWS CLI with --endpoint-url=http://localhost:4566
]


=== Vault

_Secrets management by HashiCorp_

*Docker Image:* `hashicorp/vault`

*Usage:*

```bash
# Basic usage
docker run --rm -p 8200:8200 -e VAULT_DEV_ROOT_TOKEN_ID=myroot hashicorp/vault
```

```bash
# Start
docker start vault
```

```bash
# Stop
docker stop vault
```

```bash
# Cli
docker exec -it vault vault $args
```

*Aliases:*

Bash/Zsh: `dtvault`, `dtvaultstart`, `dtvaultstop`

#block(
  fill: rgb("#fffacd"),
  inset: 8pt,
  radius: 4pt,
)[
  *Note:* Access at http://localhost:8200. Dev mode token: myroot. NOT for production!
]


#pagebreak()

== Web Servers & Security

=== Caddy

_Modern web server with automatic HTTPS_

*Docker Image:* `caddy`

*Usage:*

```bash
# Basic usage
docker run --rm -p 80:80 -p 443:443 -v ${PWD}:/usr/share/caddy caddy
```

```bash
# Start
docker start caddy
```

```bash
# Stop
docker stop caddy
```

```bash
# Reload
docker exec -w /etc/caddy caddy caddy reload
```

*Aliases:*

Bash/Zsh: `dtcaddy`, `dtcaddystart`, `dtcaddystop`

#block(
  fill: rgb("#fffacd"),
  inset: 8pt,
  radius: 4pt,
)[
  *Note:* Automatic SSL certificates from Let's Encrypt. Zero-downtime reloads.
]


=== Vaultwarden

_Lightweight Bitwarden password manager server_

*Docker Image:* `vaultwarden/server`

*Usage:*

```bash
# Basic usage
docker run --rm -p 8080:80 -v vaultwarden-data:/data vaultwarden/server
```

```bash
# Start
docker start vaultwarden
```

```bash
# Stop
docker stop vaultwarden
```

```bash
# Logs
docker logs vaultwarden -f
```

*Aliases:*

Bash/Zsh: `dtvaultwarden`, `dtvaultwardenstart`, `dtvaultwardenstop`

#block(
  fill: rgb("#fffacd"),
  inset: 8pt,
  radius: 4pt,
)[
  *Note:* Access at http://localhost:8080. Compatible with Bitwarden clients. Use HTTPS in production!
]


#pagebreak()

== Message Brokers & IoT

=== Mosquitto

_Lightweight MQTT broker for IoT_

*Docker Image:* `eclipse-mosquitto`

*Usage:*

```bash
# Basic usage
docker run --rm -p 1883:1883 -p 9001:9001 eclipse-mosquitto
```

```bash
# Sub
docker run --rm eclipse-mosquitto mosquitto_sub -h host.docker.internal $args
```

```bash
# Pub
docker run --rm eclipse-mosquitto mosquitto_pub -h host.docker.internal $args
```

```bash
# Passwd
docker run --rm -v ${PWD}:/mosquitto/config eclipse-mosquitto mosquitto_passwd $args
```

*Aliases:*

Bash/Zsh: `dtmosquitto`, `dtmqttsub`, `dtmqttpub`

#block(
  fill: rgb("#fffacd"),
  inset: 8pt,
  radius: 4pt,
)[
  *Note:* Port 1883 for MQTT, 9001 for WebSockets. Use host.docker.internal to connect.
]


#pagebreak()

== Static Site Generators

=== Jekyll

_Ruby-based static site generator, popular for GitHub Pages_

*Docker Image:* `jekyll/jekyll`

*Usage:*

```bash
# Basic usage
docker run --rm -v ${PWD}:/srv/jekyll jekyll/jekyll jekyll $args
```

```bash
# Serve
docker run --rm -v ${PWD}:/srv/jekyll -p 4000:4000 jekyll/jekyll jekyll serve --watch --force_polling
```

```bash
# Simple
docker run --rm -v ${PWD}:/site -p 4000:4000 bretfisher/jekyll-serve
```

```bash
# Build
docker run --rm -v ${PWD}:/srv/jekyll jekyll/jekyll jekyll build
```

*Aliases:*

Bash/Zsh: `dtjekyll`, `dtjekyllserve`, `dtjekyllsimple`

#block(
  fill: rgb("#fffacd"),
  inset: 8pt,
  radius: 4pt,
)[
  *Note:* The bretfisher/jekyll-serve image auto-runs bundle install and is useful for complex setups.
]


=== Hugo

_Fast static site generator written in Go_

*Docker Image:* `klakegg/hugo`

*Usage:*

```bash
# Basic usage
docker run --rm -v ${PWD}:/src klakegg/hugo $args
```

```bash
# Serve
docker run --rm -v ${PWD}:/src -p 1313:1313 klakegg/hugo server --bind 0.0.0.0
```

```bash
# New
docker run --rm -v ${PWD}:/src klakegg/hugo new site mysite
```

*Aliases:*

Bash/Zsh: `dthugo`, `dthugoserve`

#block(
  fill: rgb("#fffacd"),
  inset: 8pt,
  radius: 4pt,
)[
  *Note:* Access at http://localhost:1313
]


=== Mkdocs

_Python documentation generator with beautiful Material theme_

*Docker Image:* `squidfunk/mkdocs-material`

*Usage:*

```bash
# Basic usage
docker run --rm -v ${PWD}:/docs squidfunk/mkdocs-material $args
```

```bash
# Serve
docker run --rm -v ${PWD}:/docs -p 8000:8000 squidfunk/mkdocs-material
```

```bash
# Build
docker run --rm -v ${PWD}:/docs squidfunk/mkdocs-material build
```

```bash
# New
docker run --rm -v ${PWD}:/docs squidfunk/mkdocs-material new .
```

*Aliases:*

Bash/Zsh: `dtmkdocs`, `dtmkdocsserve`

#block(
  fill: rgb("#fffacd"),
  inset: 8pt,
  radius: 4pt,
)[
  *Note:* Access at http://localhost:8000
]


#pagebreak()

== Build & Task Runners

=== Just

_Command runner for executing project-specific tasks and recipes_

*Docker Image:* `alpine`

*Usage:*

```bash
# Basic usage
docker run --rm -v ${PWD}:/workdir -w /workdir alpine sh -c "wget -q https://github.com/casey/just/releases/download/1.16.0/just-1.16.0-x86_64-unknown-linux-musl.tar.gz -O- | tar -xz -C /usr/local/bin && just $args"
```

*Aliases:*

Bash/Zsh: `dtjust`

#block(
  fill: rgb("#fffacd"),
  inset: 8pt,
  radius: 4pt,
)[
  *Note:* Binary download adds startup time. For frequent use, consider installing natively.
]


=== Make

_GNU Make for traditional Makefile execution_

*Docker Image:* `alpine`

*Usage:*

```bash
# Basic usage
docker run --rm -v ${PWD}:/workdir -w /workdir alpine sh -c "apk add --no-cache make > /dev/null 2>&1 && make $args"
```

*Aliases:*

Bash/Zsh: `dtmake`

#block(
  fill: rgb("#fffacd"),
  inset: 8pt,
  radius: 4pt,
)[
  *Note:* Supports parallel execution with -j flag.
]


#pagebreak()

== Testing Tools

=== Playwright

_Browser automation and E2E testing framework_

*Docker Image:* `mcr.microsoft.com/playwright:latest`

*Usage:*

```bash
# Basic usage
docker run --rm -v ${PWD}:/work -w /work -it mcr.microsoft.com/playwright:latest /bin/bash
```

```bash
# Test
docker run --rm -v ${PWD}:/work -w /work mcr.microsoft.com/playwright:latest npx playwright test
```

*Aliases:*

Bash/Zsh: `dtplaywright`, `dtplaywrighttest`

#block(
  fill: rgb("#fffacd"),
  inset: 8pt,
  radius: 4pt,
)[
  *Note:* Includes Chromium, Firefox, and WebKit browsers.
]


#pagebreak()

== Code Quality & Linting

=== Prettier

_Opinionated code formatter for multiple languages_

*Docker Image:* `tmknom/prettier`

*Usage:*

```bash
# Basic usage
docker run --rm -v ${PWD}:/work tmknom/prettier $args
```

```bash
# Check
docker run --rm -v ${PWD}:/work tmknom/prettier --check .
```

```bash
# Write
docker run --rm -v ${PWD}:/work tmknom/prettier --write .
```

*Aliases:*

Bash/Zsh: `dtprettier`, `dtprettiercheck`, `dtprettierwrite`


=== Black

_Python code formatter_

*Docker Image:* `cytopia/black`

*Usage:*

```bash
# Basic usage
docker run --rm -v ${PWD}:/data cytopia/black $args
```

```bash
# Check
docker run --rm -v ${PWD}:/data cytopia/black --check .
```

*Aliases:*

Bash/Zsh: `dtblack`, `dtblackcheck`


=== Shellcheck

_Static analysis tool for shell scripts_

*Docker Image:* `koalaman/shellcheck`

*Usage:*

```bash
# Basic usage
docker run --rm -v ${PWD}:/mnt koalaman/shellcheck $args
```

*Aliases:*

Bash/Zsh: `dtshellcheck`


=== Hadolint

_Dockerfile linter_

*Docker Image:* `hadolint/hadolint`

*Usage:*

```bash
# Basic usage
docker run --rm -i hadolint/hadolint < Dockerfile
```

*Aliases:*

Bash/Zsh: `dthadolint`


=== Markdownlint

_Markdown linter_

*Docker Image:* `tmknom/markdownlint`

*Usage:*

```bash
# Basic usage
docker run --rm -v ${PWD}:/work tmknom/markdownlint $args
```

*Aliases:*

Bash/Zsh: `dtmarkdownlint`


#pagebreak()

== Media & Documents

=== Pandoc

_Universal document converter (Markdown, PDF, DOCX, etc)_

*Docker Image:* `pandoc/latex`

*Usage:*

```bash
# Basic usage
docker run --rm -v ${PWD}:/data pandoc/latex $args
```

*Aliases:*

Bash/Zsh: `dtpandoc`

*Examples:*

- _Convert Markdown to PDF_
  ```bash
  dtpandoc input.md -o output.pdf
  ```
- _Convert DOCX to Markdown_
  ```bash
  dtpandoc input.docx -o output.md
  ```


=== Ffmpeg

_Media processing tool for video and audio_

*Docker Image:* `jrottenberg/ffmpeg`

*Usage:*

```bash
# Basic usage
docker run --rm -v ${PWD}:/tmp jrottenberg/ffmpeg $args
```

*Aliases:*

Bash/Zsh: `dtffmpeg`

*Examples:*

- _Convert video to MP4_
  ```bash
  dtffmpeg -i input.avi output.mp4
  ```


=== Imagemagick

_Image manipulation and conversion_

*Docker Image:* `dpokidov/imagemagick`

*Usage:*

```bash
# Basic usage
docker run --rm -v ${PWD}:/imgs dpokidov/imagemagick convert $args
```

```bash
# Identify
docker run --rm -v ${PWD}:/imgs dpokidov/imagemagick identify $args
```

```bash
# Mogrify
docker run --rm -v ${PWD}:/imgs dpokidov/imagemagick mogrify $args
```

*Aliases:*

Bash/Zsh: `dtconvert`, `dtidentify`, `dtmogrify`


=== Yt-Dlp

_Download videos from YouTube and other sites_

*Docker Image:* `jauderho/yt-dlp`

*Usage:*

```bash
# Basic usage
docker run --rm -v ${PWD}:/downloads jauderho/yt-dlp $args
```

*Aliases:*

Bash/Zsh: `dtytdlp`


=== Typst

_Modern markup-based typesetting system_

*Docker Image:* `ghcr.io/typst/typst`

*Usage:*

```bash
# Basic usage
docker run --rm -v ${PWD}:/data ghcr.io/typst/typst compile $args
```

```bash
# Watch
docker run --rm -v ${PWD}:/data ghcr.io/typst/typst watch $args
```

*Aliases:*

Bash/Zsh: `dttypst`, `dttypstwatch`


=== Latex

_LaTeX document preparation system_

*Docker Image:* `texlive/texlive`

*Usage:*

```bash
# Basic usage
docker run --rm -v ${PWD}:/workdir -w /workdir texlive/texlive pdflatex $args
```

```bash
# Latexmk
docker run --rm -v ${PWD}:/workdir -w /workdir texlive/texlive latexmk -pdf $args
```

```bash
# Xelatex
docker run --rm -v ${PWD}:/workdir -w /workdir texlive/texlive xelatex $args
```

*Aliases:*

Bash/Zsh: `dtpdflatex`, `dtlatexmk`, `dtxelatex`


#pagebreak()

== DevOps & Cloud CLI

=== Awscli

_AWS Command Line Interface_

*Docker Image:* `amazon/aws-cli`

*Usage:*

```bash
# Basic usage
docker run --rm -v ~/.aws:/root/.aws -v ${PWD}:/aws amazon/aws-cli $args
```

*Aliases:*

Bash/Zsh: `dtaws`


=== Azurecli

_Azure Command Line Interface_

*Docker Image:* `mcr.microsoft.com/azure-cli`

*Usage:*

```bash
# Basic usage
docker run --rm -v ${PWD}:/work -w /work mcr.microsoft.com/azure-cli az $args
```

*Aliases:*

Bash/Zsh: `dtaz`


=== Gcloud

_Google Cloud Command Line Interface_

*Docker Image:* `google/cloud-sdk`

*Usage:*

```bash
# Basic usage
docker run --rm -v ~/.config/gcloud:/root/.config/gcloud -v ${PWD}:/work -w /work google/cloud-sdk gcloud $args
```

*Aliases:*

Bash/Zsh: `dtgcloud`


=== Terraform

_Infrastructure as Code tool_

*Docker Image:* `hashicorp/terraform`

*Usage:*

```bash
# Basic usage
docker run --rm -v ${PWD}:/workspace -w /workspace hashicorp/terraform $args
```

*Aliases:*

Bash/Zsh: `dtterraform`


=== Ansible

_IT automation and configuration management_

*Docker Image:* `willhallonline/ansible`

*Usage:*

```bash
# Basic usage
docker run --rm -v ${PWD}:/ansible -w /ansible willhallonline/ansible ansible $args
```

```bash
# Playbook
docker run --rm -v ${PWD}:/ansible -w /ansible willhallonline/ansible ansible-playbook $args
```

*Aliases:*

Bash/Zsh: `dtansible`, `dtansibleplaybook`


=== Helm

_Kubernetes package manager_

*Docker Image:* `alpine/helm`

*Usage:*

```bash
# Basic usage
docker run --rm -v ${PWD}:/apps -v ~/.kube:/root/.kube alpine/helm $args
```

*Aliases:*

Bash/Zsh: `dthelm`


#pagebreak()

== API Development

=== Swagger-Ui

_Interactive API documentation viewer_

*Docker Image:* `swaggerapi/swagger-ui`

*Usage:*

```bash
# Basic usage
docker run --rm -p 8080:8080 -e SWAGGER_JSON=/app/swagger.json -v ${PWD}:/app swaggerapi/swagger-ui
```

*Aliases:*

Bash/Zsh: `dtswagger`


=== Httpie

_User-friendly HTTP client_

*Docker Image:* `alpine`

*Usage:*

```bash
# Basic usage
docker run --rm -it alpine sh -c "apk add --no-cache httpie > /dev/null 2>&1 && http $args"
```

*Aliases:*

Bash/Zsh: `dthttp`, `dthttpie`


=== Newman

_Postman collection runner_

*Docker Image:* `postman/newman`

*Usage:*

```bash
# Basic usage
docker run --rm -v ${PWD}:/etc/newman postman/newman run $args
```

*Aliases:*

Bash/Zsh: `dtnewman`


#pagebreak()

== Git Tools

=== Git

_Git version control_

*Docker Image:* `alpine/git`

*Usage:*

```bash
# Basic usage
docker run --rm -v ${PWD}:/git -w /git alpine/git $args
```

*Aliases:*

Bash/Zsh: `dtgit`


=== Gh

_GitHub CLI_

*Docker Image:* `ghcr.io/cli/cli`

*Usage:*

```bash
# Basic usage
docker run --rm -v ${PWD}:/repo -w /repo -v ~/.config/gh:/root/.config/gh ghcr.io/cli/cli $args
```

*Aliases:*

Bash/Zsh: `dtgh`


#pagebreak()

== Networking & Security

=== Trivy

_Vulnerability scanner for containers and IaC_

*Docker Image:* `aquasec/trivy`

*Usage:*

```bash
# Basic usage
docker run --rm -v /var/run/docker.sock:/var/run/docker.sock -v ${PWD}:/work aquasec/trivy $args
```

*Aliases:*

Bash/Zsh: `dttrivy`


=== Nmap

_Network exploration and security scanning_

*Docker Image:* `instrumentisto/nmap`

*Usage:*

```bash
# Basic usage
docker run --rm instrumentisto/nmap $args
```

*Aliases:*

Bash/Zsh: `dtnmap`


=== Curl

_Command line HTTP client_

*Docker Image:* `curlimages/curl`

*Usage:*

```bash
# Basic usage
docker run --rm curlimages/curl $args
```

*Aliases:*

Bash/Zsh: `dtcurl`


=== Testssl

_SSL/TLS security testing_

*Docker Image:* `drwetter/testssl.sh`

*Usage:*

```bash
# Basic usage
docker run --rm drwetter/testssl.sh $args
```

*Aliases:*

Bash/Zsh: `dttestssl`


== Terminal Tools

=== Ncdu

_Disk usage analyzer with ncurses interface_

*Docker Image:* `alpine`

*Usage:*

```bash
# Basic usage
docker run --rm -it -v ${PWD}:/data alpine sh -c "apk add --no-cache ncdu > /dev/null 2>&1 && ncdu /data"
```

*Aliases:*

Bash/Zsh: `dtncdu`


=== Ranger

_Console file manager with VI key bindings_

*Docker Image:* `alpine`

*Usage:*

```bash
# Basic usage
docker run --rm -it -v ${PWD}:/data alpine sh -c "apk add --no-cache ranger > /dev/null 2>&1 && ranger /data"
```

*Aliases:*

Bash/Zsh: `dtranger`


#pagebreak()

= Appendix

== Installation

To use Docker Toolbox, you need Docker installed on your system.

*Prerequisites:*
- Docker 20.10 or later
- Basic command line knowledge

Visit #link("https://github.com/yourusername/docker-toolbox") for installation instructions.

== Contributing

Docker Toolbox uses a YAML-based tool management system. To add a new tool:

1. Edit `tools.yaml`
2. Run `python generate.py --all`
3. Test the generated outputs
4. Submit a pull request

== License

MIT License - Free to use, modify, and distribute.
