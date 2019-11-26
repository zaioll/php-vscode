# How to use
## Launch:

To launch the "IDE" and set the current folder as the root of your application:

$ docker run -ti --rm --privileged -v /tmp/.X11-unix:/tmp/.X11-unix -v "$PWD":/var/www/html -e DISPLAY=unix$DISPLAY --device /dev/dri --name vscode --net="host" insready/vscode-php

You can set up bash alias for the command above, for example:

nano ~/.bashrc

alias phpcode='docker run -ti --rm --privileged -v /tmp/.X11-unix:/tmp/.X11-unix -v "$PWD":/var/www/html -e DISPLAY=unix$DISPLAY --device /dev/dri --name vscode --net="host" insready/vscode-php'

source ~/.bashrc

Once you set up the alias above, you can simply launch your "IDE" with simple command phpcode.

## Stop:

To stop the container and auto-remove it: Just use Ctrl+C
## Use with other Docker image:

This image would work well with insready/drupal-dev, Xdebug remote debugging will simply work out of box.
## Configure Xdebug to work

This image makes assumption that the default remote server file path is at /var/www/html/. If this indeed is your remote file path, for example, you use insready/drupal-dev for setting up your Drupal develppment enviroment, then you do not need additional configuration. Otherwise, you need to create a mapping between your remote file path, and the file path inside this container, which defaults to /var/www/html/.

To create a file path mapping between remote and local file system, you have to set the localSourceRoot and serverSourceRoot settings in your launch.json, for example:

"serverSourceRoot": "/var/www/html/",
"localSourceRoot": "${cwd}"