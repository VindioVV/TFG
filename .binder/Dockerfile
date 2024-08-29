# Use the official SWI-Prolog image as the base image
FROM swipl:latest

# Install necessary system dependencies
RUN apt-get update && apt-get install -y \
    wget \
    python3-pip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install Miniconda
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /miniconda.sh && \
    bash /miniconda.sh -b -p /opt/conda && \
    rm /miniconda.sh

# Set conda environment path
ENV PATH=/opt/conda/bin:$PATH

# Create a directory for the application
WORKDIR /app

# Copy the local files to the container
COPY . /app

# Create a Conda environment and install the dependencies
RUN conda update -n base -c defaults conda && \
    conda create -n myenv python=3.12.4 voila=0.5.1 jupyterlab pandas matplotlib bqplot ipympl ipyvolume scipy -c conda-forge -c defaults && \
    /bin/bash -c "source activate myenv && pip install pyswip swiplserver==1.0.2"

# Activate the Conda environment and set it as the default
SHELL ["conda", "run", "-n", "myenv", "/bin/bash", "-c"]

# Expose the Jupyter Lab port
EXPOSE 8888

# Set the default command to start Jupyter Lab and open the specified notebook
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--no-browser", "--allow-root", "--NotebookApp.token=''"]
