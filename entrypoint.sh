#!/bin/bash

# Esperar a que la base de datos esté disponible
echo 'Esperando base de datos...'
sleep 15

# Verificar si WordPress no está instalado
if [ ! -f /var/www/html/wp-config.php ]; then
    echo 'Instalando WordPress...'
    # Instalar WordPress usando wp-cli
    wp core install --url=http://localhost:8080 --title='Tienda de Pereza' --admin_user=admin --admin_password=admin --admin_email=admin@example.com --allow-root

    # Importar el archivo XML
    echo 'Importando contenido desde el archivo XML...'
    wp import /wp-import/acediastore.xml --allow-root
fi

# Ejecutar el entrypoint de Apache para iniciar el servidor
echo 'Iniciando Apache...'
exec docker-entrypoint.sh apache2-foreground
