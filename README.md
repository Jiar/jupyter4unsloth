# Jupyter for Unsloth

- [Unsloth](https://github.com/unslothai/unsloth)
- [JupyterLab](https://github.com/jupyterlab/jupyterlab)

## Introduce
I originally built this image to be able to use unsloth for large model training on my home Windows 10 gaming machine (with Nvidia RTX4070 graphics card). It can run well on Ubuntu 22 (WSL2). If your situation is the same as mine, you can also use this image directly. Otherwise, you may need to slightly adjust this Dockerfile. Good luck.


## Run

### Run on Windows (with WSL2)
- Follow the [CUDA on WSL User Guide](https://docs.nvidia.com/cuda/wsl-user-guide/index.html)
- Do not install `Docker Desktop for Windows` and use the WSL integration features above, as it will cause CUDA to be unavailable


#### Install NVIDIA Windows Driver
Install regular Nvidia graphics drivers, usually they support WSL2

- [NVIDIA Driver Downloads](https://www.nvidia.com/Download/index.aspx)

#### Install WSL2 on Windows
This step requires the installation of WSL, and the WSL2 version is required. Then use WSL2 to install the Linux system. It is recommended to install the Ubuntu22 system.

- [Getting Started with CUDA on WSL 2](https://docs.nvidia.com/cuda/wsl-user-guide/index.html#getting-started-with-cuda-on-wsl-2)
- [Upgrade version from WSL 1 to WSL 2](https://learn.microsoft.com/en-us/windows/wsl/install#upgrade-version-from-wsl-1-to-wsl-2)


#### Install Docker Engine on Linux
After you successfully install Ubuntu22 on WSL2, you need to enter Ubuntu22 and install the Docker engine.

- [Install Docker Engine on Ubuntu](https://docs.docker.com/engine/install/ubuntu/)

#### Installing the NVIDIA Container Toolkit and Configurate it
Installing the NVIDIA Container Toolkit and Configurate it

- [Install the NVIDIA Container Toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html#installation)
- [Configurate the NVIDIA Container Toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html#configuration)


#### Run the jupyter4unsloth docker
run the jupyter4unsloth docker

```sh
docker run -d --name jupyter4unsloth \
  --gpus all --runtime=nvidia -e NVIDIA_VISIBLE_DEVICES=all \
  --privileged \
  -p 8888:8888 \
  -v /path/to/workspace:/workspace \
  jiar/jupyter4unsloth:latest
```

#### Build it yourself
If your graphics card model is not the same as mine, you may need to refer to the official instructions of [unsloth](https://github.com/unslothai/unsloth), adjust the Dockerfile slightly, and finally build your own Docker to complete the adaptation.

```sh
git clone https://github.com/Jiar/jupyter4unsloth
cd ./jupyter4unsloth
docker build -t jupyter4unsloth .
```

### Run on Linux direct
This Dockerfile is most likely compatible with Linux, but because I don't have a machine with an NVIDIA graphics card installed directly on the Linux system, I haven't tested it. On Linux, you can roughly refer to the steps of WSL, but you don't need to install WSL anymore.

## End
There is nothing here