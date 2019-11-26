FROM zahaila/php-zts:7.2

LABEL maintener 'Láyro Cristofér <layrozahaila@gmail.com>'

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
	&& su ${USUARIO} -c "code --extensions-dir $VSCODEEXT --install-extension felixfbecker.php-intellisense --install-extension felixfbecker.php-debug --install-extension whatwedo.twig --install-extension ikappas.phpcs"

COPY start.sh /usr/local/bin/start.sh

WORKDIR /var/www/html

CMD [ "start.sh" ]
