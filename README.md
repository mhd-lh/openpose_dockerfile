
# openpose_dockerfile
A dockerfile to build openpose from scratch with downloading the models from google drive.
Make sure you have a version of cmake is installed. You can either run the docker commands from the makefile, or install cmake as follows (Ubuntu 22.04):
 1.  sudo apt-add-repository 'deb https://apt.kitware.com/ubuntu/ jammy main'
 2.  sudo apt update &&  sudo apt install cmake
 
After you place the images in `image_in` folder inside docker, run openpose from inside:

    cd openpose
    ./build/examples/openpose/openpose.bin --image_dir ../image_in --hand --disable_blending --display 0 --writ
    e_json ../json_out --write_images ../image_out --num_gpu 1 --num_gpu_start 0
