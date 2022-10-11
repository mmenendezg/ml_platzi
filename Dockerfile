FROM python:3.8-slim

# Create a new user
RUN ["useradd", "--create-home", "--shell", "/bin/bash", "mmenendezg"]

# Select the working directory to home of the user
WORKDIR /home/mmenendezg/

# Install curl
RUN ["apt-get", "update", "-y"]
RUN ["apt-get", "upgrade", "-y"]
RUN ["apt", "install", "-y", "--no-install-recommends", "curl"]

# Install git
RUN ["apt", "install", "-y", "--no-install-recommends", "git"]

# Install zsh 
RUN ["apt-get", "install", "-y", "--no-install-recommends", "zsh"]

# Install Nodejs
RUN curl -sL https://deb.nodesource.com/setup_15.x | bash -
RUN ["apt-get", "install", "-y", "nodejs"]

# Copy the requirements file and install it  
COPY ["requirements.txt", "."]
RUN ["pip", "install", "--no-cache-dir", "-r", "requirements.txt"]
RUN ["jupyter", "labextension", "install", "@konodyuk/theme-ayu-mirage"]

# Install R
RUN ["apt", "install", "-y", "r-base"]

COPY ["packages.r", "."]
RUN ["Rscript", "packages.r"]

# Select the user 
USER mmenendezg

RUN curl -fsSL https://raw.githubusercontent.com/zimfw/install/master/install.zsh | zsh
RUN ["echo", "'zmodule denysdovhan/spaceship-prompt --name spaceship'", ">>", "~/.zimrc"]
RUN ["echo", "PATH=/home/mmenendezg/.zim/:$PATH", ">>", "~/.zshrc"]

# Install 2nd requirements file
COPY ["requirements_2.txt", "."]
RUN ["pip", "install", "--no-cache-dir", "-r", "requirements_2.txt"]

CMD ["zsh"]