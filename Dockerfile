FROM php:8.1-apache

# Instala el script para extensiones PHP (soluciona el error de mbstring/xml)
ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/
RUN chmod +x /usr/local/bin/install-php-extensions && \
    install-php-extensions mbstring xml

# Habilita mod_rewrite de Apache (DokuWiki lo necesita)
RUN a2enmod rewrite

# Configura el directorio de trabajo
WORKDIR /var/www/html

# Copia los archivos de DokuWiki
COPY dokuwiki /var/www/html

RUN chown -R www-www-data /var/www/html && \
    chmod -R 755 /var/www/html && \
    chmod -R 777 /var/www/html/data /var/www/html/conf

# Expone el puerto 80
EXPOSE 80

# Inicia Apache en foreground
CMD ["apache2-foreground"]

