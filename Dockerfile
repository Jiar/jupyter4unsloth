FROM nvidia/cuda:12.1.1-cudnn8-devel-ubuntu22.04

# Create a workspace directory
WORKDIR /workspace

# Update SHELL
SHELL ["/bin/bash", "-c"]

# Install the necessary software packages
RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    git \
    wget \
    vim \
    nodejs \
    npm \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Download and install Anaconda3
RUN wget https://repo.anaconda.com/archive/Anaconda3-2024.02-1-Linux-x86_64.sh -O anaconda.sh && \
    bash anaconda.sh -b -p /opt/conda && \
    rm anaconda.sh

# Create a Conda env
RUN /opt/conda/bin/conda create -y --name jupyter_env python=3.10

# Update SHELL
SHELL ["/opt/conda/bin/conda", "run", "-n", "jupyter_env", "/bin/bash", "-c"]

# Install pytorch-cuda, pytorch, cudatoolkit, xformers
RUN conda install -y pytorch-cuda=12.1 pytorch cudatoolkit xformers -c pytorch -c nvidia -c xformers

# Set pip global timeout
RUN pip config set global.timeout 3600

# Install a commonly used scientific computing library
RUN pip install numpy pandas scipy matplotlib seaborn scikit-learn datasets

# Install unsloth
# RUN pip install "unsloth[cu121-torch230] @ git+https://github.com/unslothai/unsloth.git"
RUN pip install "unsloth[cu121-ampere-torch230] @ git+https://github.com/unslothai/unsloth.git"

# Install trl, peft, accelerate, bitsandbytes
RUN pip install --no-deps trl peft accelerate bitsandbytes

# Install transformers
RUN pip install transformers

# Install JupyterLab
RUN pip install jupyterlab

# Install the JupyterLab debugging kernel
RUN pip install ipykernel
RUN python -m ipykernel install

# Install jupyter extensions
RUN pip install jupyter_contrib_nbextensions
RUN pip install jupyterlab-git
RUN pip install jupyterlab-kite
RUN pip install jupyterlab_execute_time
RUN pip install lckr_jupyterlab_variableinspector
RUN pip install ipympl

# Update SHELL
SHELL ["/bin/bash", "-c"]

# Init the Conda env
RUN /opt/conda/bin/conda init bash

# Update ~/.bashrc
RUN echo '# activate conda env' | tee -a ~/.bashrc
RUN echo 'conda activate jupyter_env' | tee -a ~/.bashrc
RUN echo '' | tee -a ~/.bashrc

# Expose the JupyterLab service port
EXPOSE 8888

# Start the JupyterLab service
ENTRYPOINT ["/opt/conda/bin/conda", "run", "-n", "jupyter_env", "--live-stream"]
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--allow-root" ,"--no-browser"]