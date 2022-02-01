FROM makarius/isabelle:Isabelle2021
ARG DEBIAN_FRONTEND=noninteractive

USER root
RUN apt-get -y update && apt-get install -y texlive-latex-extra texlive-science imagemagick wget evince git libxext6 && \
  apt-get clean && \
  rm -rf /usr/share/doc

WORKDIR /home/isabelle
RUN git clone https://github.com/isabelle-utp/utp-main.git -b release-2021
WORKDIR utp-main
RUN /home/isabelle/Isabelle/bin/isabelle build -b -d /home/isabelle/utp-main/ -l UTP UTP-Theories

ENTRYPOINT ["/home/isabelle/Isabelle/bin/isabelle", "jedit", "-d", "/home/isabelle/utp-main/"]
CMD ["-Dsun.java2d.uiScale=1.0", "-l", "UTP"]