FROM debian:jessie

RUN apt-get update && apt-get install -y \
    git \
    libxml2-dev \
    python \
    build-essential \
    make \ 
    gcc \
    python-dev \
    locales \
    python-pip 

RUN dpkg-reconfigure locales && \
    locale-gen C.UTF-8 && \
    /usr/sbin/update-locale LANG=C.UTF-8

ENV LC_ALL C.UTF-8


RUN apt-get update && apt-get install -y \
    python-matplotlib \
    python-numpy \
    python-pandas

RUN pip install ipython[notebook]==2.0
RUN pip install scikit-learn==0.14


EXPOSE 8888
CMD ipython notebook --pylab=inline --ip=* --port=8888 --notebook-dir=/home --MappingKernelManager.time_to_dead=10 --MappingKernelManager.first_beat=3
