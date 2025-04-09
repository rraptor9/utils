#!/bin/bash

# ID del contenedor
CTID=100

echo "📦 Habilitando /dev/net/tun para el contenedor LXC ID: $CTID"

# Añadir configuración al archivo del contenedor
CONF="/etc/pve/lxc/$CTID.conf"

# Verificar si ya existe la configuración, si no, añadirla
grep -q "lxc.cgroup2.devices.allow: c 10:200 rwm" $CONF || echo "lxc.cgroup2.devices.allow: c 10:200 rwm" >> $CONF
grep -q "lxc.mount.entry = /dev/net/tun dev/net/tun none bind,create=file" $CONF || echo "lxc.mount.entry = /dev/net/tun dev/net/tun none bind,create=file" >> $CONF

# Crear el dispositivo TUN si no existe en el host
if [ ! -c /dev/net/tun ]; then
    echo "📁 Creando /dev/net/tun en el host..."
    mkdir -p /dev/net
    mknod /dev/net/tun c 10 200
    chmod 600 /dev/net/tun
fi

# Reiniciar el contenedor para aplicar cambios
echo "🔁 Reiniciando contenedor $CTID..."
pct restart $CTID

echo "✅ Listo. Ahora puedes acceder al contenedor y ejecutar OpenVPN."
