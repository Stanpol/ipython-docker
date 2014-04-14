FROM phusion/baseimage:0.9.9

MAINTAINER Stanpol, <github@stanpol.ru>

# Set correct environment variables.
ENV HOME /root

# Regenerate SSH host keys. baseimage-docker does not contain any, so you
# have to do that yourself. You may also comment out this instruction; the
# init system will auto-generate one during boot.
RUN /etc/my_init.d/00_regen_ssh_host_keys.sh

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list

RUN apt-get update
RUN apt-get upgrade

#install python
RUN apt-get install -y python2.7 python-pip gcc

RUN apt-get install -y libzmq-dev
RUN apt-get install -y python-zmq

RUN pip install -U "setuptools==3.4.1"
RUN pip install -U "virtualenv==1.11.4"
RUN pip install -U "requests"
RUN pip install -U "numpy==1.8.1"
RUN pip install -U "scipy==0.14"
RUN pip install -U "ipython[notebook]==2.0"
RUN pip install -U "pandas==0.13.1"
RUN pip install -U "beautifulsoup==4.3.2"
RUN pip install -U "PIL==1.1.7"
RUN pip install -U "pycrypto==2.6.1"
RUN pip install -U "scikits-image==0.7.1"
RUN pip install -U "scikit-learn==0.14.1"
RUN pip install -U "statsmodels==0.5.0"
RUN pip install -U "simplejson==3.3.1"
RUN pip install -U "tornado==3.1.1"
RUN pip install -U "Twisted==13.1.0"

RUN apt-get -y install g++ libfreetype6-dev libpng12-dev
RUN pip install -U "matplotlib==1.3.1"

RUN echo root:developer | chpasswd

VOLUME /notebooks
WORKDIR /notebooks

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 80
CMD ipython notebook --pylab=inline --ip=* --port=80 --MappingKernelManager.time_to_dead=10 --MappingKernelManager.first_beat=3

