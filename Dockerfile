ARG DOCKER_IMAGE=pytorch/pytorch:latest
FROM $DOCKER_IMAGE

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update \
#	&& apt-get dist-upgrade -y \
	&& apt-get install -y wget libsm6 libxext6 libxrender-dev libgl1-mesa-glx \
	&& apt-get clean autoclean \
	&& apt-get autoremove --yes \
	&& rm -rf /var/lib/{apt,dpkg,cache,log}/

ADD requirements.txt requirements.txt

#RUN python -m pip install --upgrade pip && pip install --no-cache-dir -r requirements.txt && rm requirements.txt
RUN pip install --no-cache-dir -r requirements.txt && rm requirements.txt

RUN python -c "import sklearn; print(sklearn.__version__)" && echo sklearn OK || echo sklearn FAILD
RUN python -c "import torch; print(torch.__version__)" && echo torch OK || echo torch FAILD
RUN python -c "import numpy; print(numpy.__version__)" && echo numpy OK || echo numpy FAILD
RUN python -c "import cv2; print(cv2.__version__)" && echo opencv OK || echo opencv FAILD
RUN python -c "import pandas; print(pandas.__version__)" && echo pandas OK || echo pandas FAILD
RUN python -c "import scipy; print(scipy.__version__)" && echo scipy OK || echo scipy FAILD
RUN python -c "import matplotlib; print(matplotlib.__version__)" && echo matplotlib OK || echo matplotlib FAILD

LABEL author="Bensuperpc <bensuperpc@gmail.com>"
LABEL mantainer="Bensuperpc <bensuperpc@gmail.com>"

ARG VERSION="1.0.0"
ENV VERSION=$VERSION

#ENV PATH="/tendra/obj.buildkitsandbox-bootstrap/bin:${PATH}"

#WORKDIR /usr/src/myapp

#CMD ["tcc", "-V"]

LABEL org.label-schema.schema-version="1.0" \
	  org.label-schema.build-date=$BUILD_DATE \
	  org.label-schema.name="bensuperpc/torch" \
	  org.label-schema.description="Custom torch container" \
	  org.label-schema.version=$VERSION \
	  org.label-schema.vendor="Bensuperpc" \
	  org.label-schema.url="http://bensuperpc.com/" \
	  org.label-schema.vcs-url="https://github.com/bensuperpc/docker-torch" \
	  org.label-schema.vcs-ref=$VCS_REF \
	  org.label-schema.docker.cmd="docker build -t bensuperpc/torch -f Dockerfile ."
