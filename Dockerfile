FROM ubuntu

RUN apt-get update && apt-get install -y \
        apt-transport-https \
        gnupg2 \
        curl \
        software-properties-common \
        && rm -rf /var/lib/apt/lists/*

RUN curl https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
        && curl https://storage.googleapis.com/download.dartlang.org/linux/debian/dart_stable.list > /etc/apt/sources.list.d/dart_stable.list

RUN apt-get update && apt-get install -y \
        dart \
        && rm -rf /var/lib/apt/lists/*

RUN add-apt-repository ppa:ubuntu-elisp/ppa

RUN apt-get update && apt-get install -y \
        emacs-snapshot \
        && rm -rf /var/lib/apt/lists/*

ADD .emacs.d /root/.emacs.d
RUN emacs -batch -l ~/.emacs.d/install.el
ADD console-simple console-simple
CMD emacs console-simple/bin/main.dart
