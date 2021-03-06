FROM debian:latest


ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV PATH /opt/conda/bin:$PATH


RUN apt-get update --fix-missing && apt-get install -y wget bzip2 ca-certificates \
    libglib2.0-0 libxext6 libsm6 libxrender1 \
    git mercurial subversion build-essential node-less

RUN apt-get install -y curl grep sed dpkg && \
    TINI_VERSION=`curl https://github.com/krallin/tini/releases/latest | grep -o "/v.*\"" | sed 's:^..\(.*\).$:\1:'` && \
    curl -L "https://github.com/krallin/tini/releases/download/v${TINI_VERSION}/tini_${TINI_VERSION}.deb" > tini.deb && \
    dpkg -i tini.deb && \
    rm tini.deb && \
    apt-get clean

RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh && \
    /bin/bash ~/miniconda.sh -b -p /opt/conda && \
    rm ~/miniconda.sh && \
    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh

RUN conda config --set always_yes yes --set changeps1 no && \
    conda config --add channels conda-forge && \
    conda update -n base conda  && \
    conda update -q --all
    # conda info -a

RUN conda install numpy scipy matplotlib nlopt swig
RUN pip install sphinx sphinx_bootstrap_theme sphinx_gallery \
    coverage awscli flake8 click \
    python-dotenv ipython Image \
    pytest pytest-cov black

RUN apt-get -y install fonts-roboto

# RUN echo "export PS1='\[\033[1;31m\]\${APPNAME} \[\033[1;34m\]\w\[\033[0;35m\] \[\033[1;36m\]\n# \[\033[0m\]'" >> ~/.bashrc

COPY . /root


ENV APPNAME pyapps

ENTRYPOINT [ "/usr/bin/tini", "--" ]
CMD [ "/bin/bash" ]
