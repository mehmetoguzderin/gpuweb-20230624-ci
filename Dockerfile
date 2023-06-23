FROM ubuntu:23.04

ENV LANG=en_US.UTF-8

RUN \
  export DEBIAN_FRONTEND=noninteractive && \
  apt update -y && \
  apt install -y locales && \
  locale-gen en_US.UTF-8 && \
  apt install -y python3-full python3-pip nodejs npm

RUN \
  export DEBIAN_FRONTEND=noninteractive && \
  python3 -m pip install --break-system-packages \
    bikeshed==3.12.1 \
    tree_sitter==0.20.1 && \
  npx --yes -- @mermaid-js/mermaid-cli@9.1.4 --version && \
  npx --yes -- tree-sitter-cli@0.20.7 --version && \
  mkdir /grammar && \
  echo '{ \
    "name": "tree-sitter-wgsl", \
    "dependencies": { \
        "nan": "^2.15.0" \
    }, \
    "devDependencies": { \
        "tree-sitter-cli": "^0.20.7" \
    }, \
    "main": "bindings/node" \
  }' > /grammar/package.json && \
  cd /grammar && \
  npm install
  
RUN \
  export DEBIAN_FRONTEND=noninteractive && \
  bikeshed update
