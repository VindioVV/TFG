# Use the swi-prolog image as the base
FROM swi-prolog:8.3.33

# Install Miniconda
RUN apt-get update && \
    apt-get install -y wget && \
    wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
    bash Miniconda3-latest-Linux-x86_64.sh -b -p /opt/conda && \
    rm Miniconda3-latest-Linux-x86_64.sh

# Update PATH environment variable
ENV PATH /opt/conda/bin:$PATH

# Copy the environment.yml file into the container
COPY environment.yml /app/environment.yml

# Create the Conda environment and install dependencies
RUN conda env create -f /app/environment.yml && \
    conda clean --all --yes

# Set the working directory
WORKDIR /app

# Copy the rest of the application files
COPY . /app

# Expose port for Jupyter
EXPOSE 8888

# Command to start Jupyter Lab
CMD ["conda", "run", "-n", "myenv", "jupyter", "lab", "--ip=0.0.0.0", "--no-browser", "--allow-root"]
