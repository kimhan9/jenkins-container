FROM jenkins/jenkins:lts

ARG TF_VERSION=1.8.3
ARG ANSIBLE_VERSION=8.5.0
USER root

# Install Jenkins
RUN apt-get update && \
    apt-get install -y apt-transport-https \
                       ca-certificates \
                       curl \
                       gnupg2 \
                       software-properties-common && \
    curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - && \
    add-apt-repository \
      "deb [arch=arm64] https://download.docker.com/linux/debian \
      $(lsb_release -cs) \
      stable" && \
    apt-get update && \
    apt-get install -y docker-ce && \
    usermod -aG docker jenkins

# Install Terraform
RUN apt-get update && \
    apt-get install -y wget unzip python3-venv && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean
RUN wget https://releases.hashicorp.com/terraform/${TF_VERSION}/terraform_${TF_VERSION}_linux_amd64.zip && \
    unzip terraform_${TF_VERSION}_linux_amd64.zip && \
    mv terraform /usr/local/bin && \
    rm terraform_${TF_VERSION}_linux_amd64.zip

# Create a virtual environment for Python
RUN python3 -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# Install Ansible
RUN pip install --upgrade pip cffi && \
    pip install ansible && \
    pip install mitogen ansible-lint jmespath && \
    pip install --upgrade pywinrm
