FROM nvcr.io/nvidia/pytorch:22.07-py3
ARG DEBIAN_FRONTEND=noninteractive
RUN apt update; apt upgrade -y
RUN apt install -y libprotobuf-dev protobuf-compiler
RUN apt-get update && apt-get -y install cmake protobuf-compiler
RUN cd /workspace
RUN rm -rf *
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends libopencv-dev
RUN apt -qq install -y libatlas-base-dev libprotobuf-dev libleveldb-dev libsnappy-dev libhdf5-serial-dev protobuf-compiler libgflags-dev libgoogle-glog-dev liblmdb-dev opencl-headers ocl-icd-opencl-dev libviennacl-dev
RUN apt -y install libboost-filesystem-dev build-essential libboost-system-dev libboost-thread-dev libboost-program-options-dev libboost-test-dev
RUN apt-get update && apt-get install ffmpeg libsm6 libxext6  -y
RUN git clone https://github.com/CMU-Perceptual-Computing-Lab/openpose.git 
WORKDIR "/workspace/openpose"
RUN git submodule update --init --recursive --remote
RUN mkdir build
WORKDIR "/workspace/openpose/models"
ADD modelsdrive.sh modelsdrive.sh
RUN apt-get install dos2unix
RUN dos2unix -k -o modelsdrive.sh
RUN chmod +x modelsdrive.sh
RUN sh modelsdrive.sh
WORKDIR "/workspace/openpose/build"
RUN cmake .. -DUSE_CUDNN=OFF
RUN cmake .. -DUSE_CUDNN=OFF
RUN make -j`nproc`
WORKDIR "/workspace"
RUN mkdir image_in
RUN mkdir json_out
RUN mkdir image_out
