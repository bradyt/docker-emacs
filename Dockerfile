FROM silex/emacs

RUN apt-get update && apt-get install -y \
        openjdk-8-jdk-headless \
        && rm -rf /var/lib/apt/lists/*

ADD .emacs.d /root/.emacs.d
RUN emacs -batch -l ~/.emacs.d/install.el -f lsp-java-update-server

ADD HelloWorld.java /root/HelloWorld.java

WORKDIR /root/
CMD "bash"
