FROM php:8.1-apache
# Instala extensiones PHP necesarias para DokuWiki
RUN docker-php-ext-install mbstring xml
# Habilita mod_rewrite de Apache (DokuWiki lo necesita)
RUN a2enmod rewrite
# Configura el documento root
WORKDIR /var/www/html
# Copia los archivos de DokuWiki
COPY dokuwiki/ .
# Permisos necesarios para que Apache pueda escribir
RUN chown -R www-data:www-data /var/www/html && \
chmod -R 755 /var/www/html && \
chmod -R 777 /var/www/html/data && \
chmod -R 777 /var/www/html/conf
# Expone el puerto 80
EXPOSE 80
# Inicia Apache
CMD ["apache2-foreground"]