#!/bin/bash

docker run -d --name jupyter4unsloth \
  --gpus all --runtime=nvidia -e NVIDIA_VISIBLE_DEVICES=all \
  --privileged \
  -p 8888:8888 \
  -v /mnt/l/LLM/jupyter4unsloth/workspace:/workspace \
  jiar/jupyter4unsloth:latest

