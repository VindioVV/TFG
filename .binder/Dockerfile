FROM continuumio/miniconda3

# Instala SWI-Prolog y otras dependencias
RUN apt-get update && \
    apt-get install -y software-properties-common && \
    add-apt-repository ppa:swi-prolog/stable && \
    apt-get update && \
    apt-get install -y swi-prolog

# Instala paquetes de Conda y Pip
RUN conda install -y voila jupyterlab && \
    pip install swiplserver

# Copia los archivos del repositorio al contenedor
COPY . /app

# Establece el directorio de trabajo
WORKDIR /app

# Configura el entorno para ejecutar Voila
CMD ["voila", "--port=8888", "--no-browser", "--allow-root"]