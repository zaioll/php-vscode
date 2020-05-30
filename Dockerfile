FROM zaioll/php-zts:7.2

LABEL maintener 'Láyro Chrystofer <zaioll@protonmail.com>'

ENV USUARIO developer
ENV HOME /home/${USUARIO}
ENV VSCODEEXT /var/vscode-ext

RUN apt-get update && apt-get install -y \
	apt-transport-https \
	ca-certificates \
	curl \
	gnupg \
	git \
	--no-install-recommends

RUN curl -sSL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | apt-key add - \
    && echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list
#    && wget -q https://packages.sury.org/php/apt.gpg -O- | apt-key add - && echo "deb https://packages.sury.org/php/ stretch main" | tee /etc/apt/sources.list.d/php.list

RUN apt-get update && apt-get -y install \
	code \
	libasound2 \
	libatk1.0-0 \
	libcairo2 \
	libcups2 \
	libexpat1 \
	libfontconfig1 \
	libfreetype6 \
	libgtk2.0-0 \
	libpango-1.0-0 \
	libx11-xcb1 \
	libxcomposite1 \
	libxcursor1 \
	libxdamage1 \
	libxext6 \
	libxfixes3 \
	libxi6 \
	libxrandr2 \
	libxrender1 \
	libxss1 \
	libxtst6 \
    #php7.2-cli php7.2-common php7.2-curl php7.2-mbstring php7.2-mysql php7.2-xml \
	--no-install-recommends \
	&& rm -rf /var/lib/apt/lists/*

RUN \
    useradd --create-home --home-dir $HOME ${USUARIO} \
    && mkdir /var/www/html -p \
	&& chown -R ${USUARIO}:${USUARIO} $HOME /var/www/html

RUN mkdir $VSCODEEXT \
    && chown -R ${USUARIO}:${USUARIO} $VSCODEEXT \
	&& su ${USUARIO} -c "code --extensions-dir $VSCODEEXT --install-extension felixfbecker.php-intellisense --install-extension felixfbecker.php-debug --install-extension whatwedo.twig --install-extension ikappas.phpcs --install-extension ecodes.vscode-phpmd --install-extension bmewburn.vscode-intelephense-client --install-extension MehediDracula.php-namespace-resolver --install-extension phproberto.vscode-php-getters-setters --install-extension naumovs.color-highlight --install-extension anseki.vscode-color --install-extension vscode-icons-team.vscode-icons --install-extension eamodio.gitlens --install-extension Zignd.html-css-class-completion --install-extension raynigon.nginx-formatter --install-extension mrmlnc.vscode-apache --install-extension mechatroner.rainbow-csv --install-extension jock.svg --install-extension tyriar.terminal-tabs --install-extension formulahendry.terminal --install-extension ms-vscode.vscode-typescript-tslint-plugin --install-extension mgmcdermott.vscode-language-babel --install-extension michelemelluso.code-beautifier --install-extension editorconfig.editorconfig --install-extension donjayamanne.githistory --install-extension ecmel.vscode-html-css --install-extension doublefint.pgsql --install-extension mehedidracula.php-constructor --install-extension neilbrayfield.php-docblocker --install-extension marabesi.php-import-checker --install-extension chrmarti.regex --install-extension imperez.smarty --install-extension vscodevim.vim --install-extension davidanson.vscode-markdownlint --install-extension compulim.vscode-clock --install-extension mutantdino.resourcemonitor --install-extension dotjoshjohnson.xml --install-extension visualstudioexptteam.vscodeintellicode --install-extension yzhang.markdown-all-in-one" \
    && su ${USUARIO} -c "composer global require phpunit/phpunit" \
    && su ${USUARIO} -c "composer global require phpmd/phpmd" \
    && su ${USUARIO} -c "composer global require squizlabs/php_codesniffer" \
    && su ${USUARIO} -c "composer global require \"fxp/composer-asset-plugin:1.4.4\""

COPY start.sh /usr/local/bin/start.sh
COPY settings.json ${HOME}/.config/Code/User

RUN chown ${USUARIO}:${USUARIO} $HOME/.config/Code/User/settings.json

WORKDIR /var/www/html

CMD [ "/usr/local/bin/start.sh" ]
