FROM benvial/pyapps:latest

RUN apt-get install -y libglu1 libxinerama1 libxft-dev libxcursor1

COPY . .

RUN ./install_onelab linux /opt/onelab/bin dev

ENV PATH /opt/onelab/bin:$PATH

ENV APPNAME pyonelab

ENTRYPOINT [ "/usr/bin/tini", "--" ]
CMD [ "/bin/bash" ]
