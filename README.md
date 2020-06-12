# PHP development enviroment

- [vscode](https://code.visualstudio.com/)
    - Extentions
        - formulahendry.auto-close-tag
        - ymotongpoo.licenser
        - yzhang.markdown-all-in-one
        - wakatime.vscode-wakatime
        - esbenp.prettier-vscode
        - piotrpalarz.vscode-gitignore-generator
        - formulahendry.auto-complete-tag
        - vsls-contrib.codetour
        - coenraads.bracket-pair-colorizer
        - ms-vscode-remote.vscode-remote-extensionpack
        - felixfbecker.php-intellisense
        - felixfbecker.php-debug
        - whatwedo.twig
        - ikappas.phpcs
        - ecodes.vscode-phpmd
        - bmewburn.vscode-intelephense-client
        - MehediDracula.php-namespace-resolver
        - phproberto.vscode-php-getters-setters
        - naumovs.color-highlight
        - anseki.vscode-color
        - vscode-icons-team.vscode-icons
        - eamodio.gitlens
        - Zignd.html-css-class-completion
        - raynigon.nginx-formatter
        - mrmlnc.vscode-apache
        - mechatroner.rainbow-csv
        - jock.svg
        - tyriar.terminal-tabs
        - formulahendry.terminal
        - ms-vscode.vscode-typescript-tslint-plugin
        - mgmcdermott.vscode-language-babel
        - michelemelluso.code-beautifier
        - editorconfig.editorconfig
        - donjayamanne.githistory
        - ecmel.vscode-html-css
        - doublefint.pgsql
        - mehedidracula.php-constructor
        - neilbrayfield.php-docblocker
        - marabesi.php-import-checker
        - chrmarti.regex
        - imperez.smarty
        - vscodevim.vim
        - davidanson.vscode-markdownlint
        - compulim.vscode-clock
        - mutantdino.resourcemonitor
        - dotjoshjohnson.xml
        - visualstudioexptteam.vscodeintellicode

- [php-fpm](https://github.com/zaioll/php-zts)
- [nvm](https://github.com/nvm-sh/nvm)
- [nodejs](https://nodejs.org/en/)

## How to use
### Launch:

To launch the "IDE" and set the current folder as the root of your application:

```
$ docker run -ti --rm --privileged -v /tmp/.X11-unix:/tmp/.X11-unix -v "$PWD":/var/www/html -e DISPLAY=unix$DISPLAY --device /dev/dri --name vscode --net="host" zaioll/vscode-php:latest
```

You can set up bash alias for the command above, for example:

nano ~/.bashrc

alias phpcode='docker run -ti --rm --privileged -v /tmp/.X11-unix:/tmp/.X11-unix -v "$PWD":/var/www/html -e DISPLAY=unix$DISPLAY --device /dev/dri --name vscode --net="host" zaioll/vscode-php:latest'

source ~/.bashrc

Once you set up the alias above, you can simply launch your "IDE" with simple command phpcode.

### Stop:

To stop the container and auto-remove it: Just use Ctrl+C
### Use with other Docker image:

This image would work well with insready/drupal-dev, Xdebug remote debugging will simply work out of box.

### Configure Xdebug to work

This image makes assumption that the default remote server file path is at /var/www/html/. If this indeed is your remote file path, for example, you use insready/drupal-dev for setting up your Drupal develppment enviroment, then you do not need additional configuration. Otherwise, you need to create a mapping between your remote file path, and the file path inside this container, which defaults to /var/www/html/.

To create a file path mapping between remote and local file system, you have to set the localSourceRoot and serverSourceRoot settings in your launch.json, for example:

"serverSourceRoot": "/var/www/html/",
"localSourceRoot": "${cwd}"