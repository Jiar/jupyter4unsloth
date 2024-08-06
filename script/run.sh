#!/bin/bash

# Fix the bug that unsloth does not support multiple GPUs with `--gpus 1`
docker run -d --name jupyter4unsloth \
  --gpus 1 \
  -p 8888:8888 \
  -v /path/to/workspace:/workspace \
  jiar/jupyter4unsloth:latest

