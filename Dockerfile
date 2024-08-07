# Use a base image with Python 3.10 and pip installed
FROM python:3.10-slim

# Accept arguments for GitHub and ngrok
ARG GITHUB_REPO=""
ARG GITHUB_BRANCH="main"
ARG GITHUB_USERNAME=""
ARG GITHUB_TOKEN=""
ARG GITHUB_EMAIL=""
ARG NGROK_AUTHTOKEN=""

# Set environment variables
ENV NGROK_AUTHTOKEN=${NGROK_AUTHTOKEN}
ENV DEBIAN_FRONTEND=noninteractive

# Install basic dependencies
RUN apt-get update && apt-get install -y \
    openjdk-11-jre-headless \
    wget \
    unzip \
    git \
    curl \
    python3-pip \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

ENV DEBIAN_FRONTEND=dialog

# Configurer les variables d'environnement
ENV HADOOP_HOME=/usr/local/hadoop
ENV PATH=$PATH:$HADOOP_HOME/bin
ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
ENV PATH=$PATH:$JAVA_HOME/bin

# Installer Hadoop client
RUN wget https://archive.apache.org/dist/hadoop/common/hadoop-3.3.5/hadoop-3.3.5.tar.gz && \
    tar -xzvf hadoop-3.3.5.tar.gz && \
    mv hadoop-3.3.5 /usr/local/hadoop && \
    rm hadoop-3.3.5.tar.gz

# Clone the GitHub repository
WORKDIR /content
RUN if [ ! -z "$GITHUB_REPO" ]; then \
      git clone --branch $GITHUB_BRANCH https://$GITHUB_USERNAME:$GITHUB_TOKEN@$GITHUB_REPO . && \
      git config user.name "$GITHUB_USERNAME" && \
      git config user.email "$GITHUB_EMAIL"; \
    fi

# Installer Git LFS
RUN curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash
RUN apt-get install git-lfs
# Download large files
RUN git lfs pull

# Install Python dependencies
RUN pip3 install --no-cache-dir -r requirements.txt


# Expose the default port for Jupyter
EXPOSE 8888

# Command to start the Jupyter server with ngrok
CMD ["python3", "run_jupyter_with_ngrok.py"]
