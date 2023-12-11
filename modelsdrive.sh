#!/bin/bash

# ------------------------- BODY, FOOT, FACE, AND HAND MODELS -------------------------
# Downloading body pose (COCO and MPI), face and hand models
POSE_FOLDER="pose/"
FACE_FOLDER="face/"
HAND_FOLDER="hand/"

# ------------------------- POSE (BODY+FOOT) MODELS -------------------------
# Body (BODY_25)
BODY_25_FOLDER=${POSE_FOLDER}"body_25/"
FILEID="1jehFU9xsxEpxRuOEUgA5jaCutR4l9X8a"
FILENAME="pose_iter_584000.caffemodel"
wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id='$FILEID -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=$FILEID" -O $FILENAME && rm -rf /tmp/cookies.txt
mv $FILENAME $BODY_25_FOLDER

# Body (COCO)
COCO_FOLDER=${POSE_FOLDER}"coco/"
FILEID="12k5CXCH4ZmCnXeBxPSkl0WNgJxj9oRVC"
FILENAME="pose_iter_440000.caffemodel"
wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id='$FILEID -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=$FILEID" -O $FILENAME && rm -rf /tmp/cookies.txt
mv $FILENAME $COCO_FOLDER


# Body (MPI)
MPI_FOLDER=${POSE_FOLDER}"mpi/"
FILEID="16RbSDNfR-xNBgcjt3o2FeermGTPEQnWC"
FILENAME="pose_iter_160000.caffemodel"
wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id='$FILEID -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=$FILEID" -O $FILENAME && rm -rf /tmp/cookies.txt
mv $FILENAME $MPI_FOLDER


# "------------------------- FACE MODELS -------------------------"
# Face
FILEID="1te1d4PwD1KjVDBW5eHmZ_08dcUoIOdAB"
FILENAME="pose_iter_116000.caffemodel"
wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id='$FILEID -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=$FILEID" -O $FILENAME && rm -rf /tmp/cookies.txt
mv $FILENAME $FACE_FOLDER

# "------------------------- HAND MODELS -------------------------"
# Hand
FILEID="1DsTdDmr2AOZlXvwSzoO4B8uRjBruy7WY"
FILENAME="pose_iter_102000.caffemodel"
wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id='$FILEID -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=$FILEID" -O $FILENAME && rm -rf /tmp/cookies.txt
mv $FILENAME $HAND_FOLDER
