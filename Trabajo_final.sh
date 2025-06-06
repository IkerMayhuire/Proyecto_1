#!/bin/bash

function bienvenida() {
  echo "************************************************"
  echo "        🚀 BIENVENIDO AL PROYECTO_1 🚀         "
  echo "************************************************"
  echo ""
}

function verificar_nmap() {
  if ! command -v nmap &> /dev/null; then
    echo "📦 Nmap no está instalado. Instalando..."
    if [[ "$OS" == "Linux" ]]; then
      if [ -f /etc/debian_version ]; then
        apt update && apt install -y nmap whois dnsutils cron
        systemctl enable --now cron
      elif [ -f /etc/redhat-release ]; then
        dnf install -y nmap whois bind-utils cronie
        systemctl enable --now crond
      fi
    elif [[ "$OS" == "Darwin" ]]; then
      brew install nmap whois bind cron
    else
      echo "❌ No se pudo instalar Nmap automáticamente. Instálalo manualmente."
      exit 1
    fi
    echo "✅ Herramientas instaladas con éxito."
  else
    echo "✅ Nmap ya está instalado."
  fi
}

function mostrar_menu() {
  echo ""
  echo "***********************************************"
  echo "        🚀 BIENVENIDO AL PROYECTO_1 🚀        "
  echo "***********************************************"
  echo "1. Verificar Sistema operativo"
  echo "2. Escanear Puertos"
  echo "3. Escanear equipos"
  echo "4. Realizar DOS"
  echo "5. Opcion Whois"
  echo "0. Salir"
  echo ""
}

function leer_objetivo() {
  read -p "🧭 Ingrese una IP o dominio a escanear: " OBJETIVO
}

function verificar_sistema() {
  echo "🔍 Verificando sistema operativo..."
  OS=$(uname -s)
  echo "✅ Sistema detectado: $OS"
}
                        
function escanear_puertos() {
  leer_objetivo
  nmap --stats-every 5s -p- "$OBJETIVO"
}

function escanear_equipos() {
  leer_objetivo
  nmap --stats-every 5s -sn "$OBJETIVO"
}

function realizar_DOS() {
y="S"
i=1
read -p "Ingrese la direcciòn IP que desea atacar: " ATAQUE
while [ $y == "S" ]
do
        ((i=1))
        while [ $i -le 5 ]
        do
        ping -c 10 $ATAQUE
        ((i++))
done
read -p "¿Desea continuar con el ataque? S o N: " y
done
}
                                  
function escanear_whois() {
  read -p "🌍 Ingrese un dominio para consultar: " DOMAIN
  echo "📋 WHOIS:"
  whois "$DOMAIN" 2>/dev/null | head -n 10
  echo ""
  echo "🔍 DIG:"
  dig "$DOMAIN" +short
  echo ""
  echo "🔎 NSLOOKUP:"
  nslookup "$DOMAIN"
}

# -------------------------------
# EJECUCIÓN PRINCIPAL DEL SCRIPT
# -------------------------------

clear
bienvenida
verificar_sistema
verificar_nmap

while true; do
  mostrar_menu
  read -p "Seleccione una opción [0-5]: " OPCION
  case $OPCION in
    1) verificar_sistema ;;
    2) escanear_puertos ;;
    3) escanear_equipos ;;
    4) realizar_DOS ;;
    5) escanear_whois ;;
    0) echo "👋 ¡Gracias por usar el Proyecto_1!"; exit 0 ;;
    *) echo "❌ Opción no válida. Intente de nuevo." ;;
  esac
  echo ""
  read -p "Presione Enter para continuar..." dummy
  clear
done
