#!/bin/bash

# Salir si ocurre algún error
set -e

echo "🚀 Actualizando el sistema..."
apt update && apt upgrade -y

echo "🚀 Instalando entorno gráfico XFCE y xrdp..."
apt install -y xfce4 xfce4-goodies xrdp dbus-x11 xserver-xorg

echo "🚀 Configurando xrdp para usar XFCE..."
echo "xfce4-session" > /root/.xsession
chmod +x /root/.xsession

echo "🚀 Ajustando permisos de xrdp..."
usermod -a -G ssl-cert xrdp

echo "🔹 Habilitando y reiniciando el servicio xrdp..."
systemctl enable xrdp
systemctl restart xrdp

echo "🚀 Instalación completada🚀"
echo "Puedes conectarte usando Remote Desktop (RDP) a la IP del contenedor."
