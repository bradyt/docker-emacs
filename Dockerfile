FROM silex/emacs

RUN apt-get update

ADD .emacs.d /root/.emacs.d
RUN emacs -batch -l ~/.emacs.d/init.el

WORKDIR /root/
CMD "bash"
