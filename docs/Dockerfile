FROM ubuntu:latest
RUN apt update
RUN apt install -y pandoc
RUN apt install -y texlive-full
RUN apt install -y wget xz-utils
# Install pandoc-crossref for installed pandoc (which is v3.1.3 at the moment)
RUN wget https://github.com/lierdakil/pandoc-crossref/releases/download/v0.3.16.0a/pandoc-crossref-Linux.tar.xz
RUN tar -xf pandoc-crossref-Linux.tar.xz
RUN mv pandoc-crossref /usr/local/bin

WORKDIR /data

ENTRYPOINT [ "/usr/bin/pandoc" ]
