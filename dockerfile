FROM nvcr.io/nvidia/pytorch:22.07-py3
ARG DEBIAN_FRONTEND=noninteractive
RUN apt update; apt upgrade -y
RUN apt install -y libprotobuf-dev protobuf-compiler
RUN apt-get update && apt-get -y install cmake protobuf-compiler
RUN cd /workspace
RUN rm -rf *
RUN mkdir dataset
RUN mkdir dataset/agnostic-v3.2
RUN mkdir dataset/cloth
RUN mkdir dataset/cloth-mask
RUN mkdir dataset/image
RUN mkdir dataset/image-densepose
RUN mkdir dataset/image-parse-agnostic-v3.2
RUN mkdir dataset/image-parse-v3
RUN mkdir dataset/openpose_img
RUN mkdir dataset/openpose_json
RUN apt-get update && apt-get install ffmpeg libsm6 libxext6  -y
RUN apt update; apt upgrade -y
WORKDIR /workspace
RUN git clone https://github.com/mhd-lh/detectron2_modified.git
RUN python -m pip install -e detectron2_modified
WORKDIR /workspace/detectron2_modified/projects/DensePose
RUN pip install av>=8.0.3 scipy>=1.5.4
RUN pip install opencv-contrib-python==4.5.5.62
RUN wget https://dl.fbaipublicfiles.com/densepose/densepose_rcnn_R_50_FPN_s1x/165712039/model_final_162be9.pkl
WORKDIR /workspace
RUN conda create -n cihp python=3.7
SHELL ["conda", "run", "--no-capture-output", "-n", "cihp", "/bin/bash", "-c"]
RUN conda install -c conda-forge cudatoolkit=10.0 cudnn=7.6.5
RUN pip install tensorflow-gpu==1.15
RUN pip install scipy==1.7.3 opencv-python==4.5.5.62 protobuf==3.19.1 Pillow==9.0.1 matplotlib==3.5.1 tqdm
RUN git clone https://github.com/mhd-lh/CIHP_PGN.git
WORKDIR /workspace/CIHP_PGN
RUN mkdir checkpoint
RUN chmod +x modelsdrive.sh
RUN sh modelsdrive.sh
RUN rm -rf datasets/*
RUN deactivate
SHELL ["/bin/bash", "-c"]
RUN conda create -n cloth_mask
SHELL ["conda", "run", "--no-capture-output", "-n", "cloth_mask", "/bin/bash", "-c"]
WORKDIR /workspace
RUN pip install carvekit_colab
RUN pip install opencv-python==4.5.5.64
RUN python -c "from carvekit.ml.files.models_loc import download_all;download_all();"
ADD mask.py mask.py
RUN deactivate
SHELL ["/bin/bash", "-c"]
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends libopencv-dev
RUN apt -qq install -y libatlas-base-dev libprotobuf-dev libleveldb-dev libsnappy-dev libhdf5-serial-dev protobuf-compiler libgflags-dev libgoogle-glog-dev liblmdb-dev opencl-headers ocl-icd-opencl-dev libviennacl-dev
RUN apt -y install libboost-filesystem-dev build-essential libboost-system-dev libboost-thread-dev libboost-program-options-dev libboost-test-dev
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
RUN pip install Pillow tqdm
ADD human_agnostic.py human_agnostic.py
ADD parse_agnostic.py parse_agnostic.py
