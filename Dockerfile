FROM sugartensor/sugartensor:1.0.0.2
# MAINTAINER Namju Kim namju.kim@kakaocorp.com

# ffmpeg requirements
RUN add-apt-repository ppa:mc3man/trusty-media
RUN apt-get update
RUN apt-get dist-upgrade -y
RUN apt-get -y install ffmpeg

# Manually download dependencies into requirements/ folder
COPY * .
RUN pip install requirements/pandas-0.19.2-cp27-cp27mu-manylinux1_x86_64.whl
RUN pip install requirements/audioread-2.1.9.tar.gz
RUN pip install requirements/joblib-0.10.0-py2.py3-none-any.whl
RUN pip install requirements/Cython-0.24-cp27-cp27mu-manylinux1_x86_64.whl
RUN pip install requirements/resampy-0.1.4.tar.gz
RUN pip install requirements/librosa-0.5.0.tar.gz
RUN pip install requirements/jupyterlab-0.16.0-py2.py3-none-any.whl

# requirements
# RUN pip install --upgrade pip
# RUN pip install pandas==0.19.2
# RUN pip install librosa==0.5.0
# RUN pip install scikits.audiolab==0.11.0
# TODO - Install jupyterlab
# RUN pip install --trusted-host pypi.org --trusted-host pypi.python.org --trusted-host files.pythonhosted.org jupyterlab

# copy pre-trained weight and some sample audio data
RUN mkdir -p /root/speech-to-text-wavenet/
RUN mkdir -p /root/speech-to-text-wavenet/asset/data/LibriSpeech/test-clean/1089/134686
RUN mkdir -p /root/speech-to-text-wavenet/asset/train
ADD *.py /root/speech-to-text-wavenet/
ADD asset/train/checkpoint /root/speech-to-text-wavenet/asset/train/
ADD asset/train/model.ckpt-205919* /root/speech-to-text-wavenet/asset/train/
# ADD asset/data/LibriSpeech/test-clean/1089/134686/* /root/speech-to-text-wavenet/asset/data/LibriSpeech/test-clean/1089/134686/

# set default directory
WORKDIR /root/speech-to-text-wavenet

# default entry point
# ENTRYPOINT bash
ENTRYPOINT jupyter lab