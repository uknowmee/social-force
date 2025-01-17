FROM ubuntu:latest
RUN apt update
RUN apt install -y pandoc
RUN apt install -y texlive-full
RUN apt install -y wget xz-utils
RUN wget https://github.com/lierdakil/pandoc-crossref/releases/latest/download/pandoc-crossref-Linux-X64.tar.xz
RUN tar -xf pandoc-crossref-Linux-X64.tar.xz
RUN mv pandoc-crossref /usr/local/bin

WORKDIR /data

ENTRYPOINT [ "/usr/bin/pandoc" ]
