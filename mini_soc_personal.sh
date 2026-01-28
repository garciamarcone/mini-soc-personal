#!/bin/bash
# ==========================================
# MINI SOC PERSONAL – DASHBOARD RÁPIDO
# Autor: Agustín García Marcone
# Fecha: 28/01/2026
# Descripción:
# Script para monitoreo rápido en Linux/WSL:
# - IPs y red
# - Espacio en disco
# - Procesos top CPU/Memoria
# - Puertos escuchando
# - Conexiones activas
# - DNS y resolución de nombres
# ==========================================

# Colores para terminal
GREEN="\033[0;32m"
BLUE="\033[0;34m"
YELLOW="\033[1;33m"
NC="\033[0m"

echo -e "${BLUE}==================================="
echo "          MINI SOC PERSONAL        "
echo "===================================${NC}"
echo -e "${GREEN}Fecha y hora:${NC} $(date)"
echo

echo -e "${YELLOW}[+] DIRECCIONES IP DEL SISTEMA${NC}"
ip a | grep inet
echo

echo -e "${YELLOW}[+] ESPACIO EN DISCO${NC}"
df -h
echo

echo -e "${YELLOW}[+] TOP 5 PROCESOS POR CPU${NC}"
ps aux --sort=-%cpu | head -6
echo

echo -e "${YELLOW}[+] TOP 5 PROCESOS POR MEMORIA${NC}"
ps aux --sort=-%mem | head -6
echo

echo -e "${YELLOW}[+] PUERTOS ESCUCHANDO${NC}"
sudo ss -tulnp | grep LISTEN
echo

echo -e "${YELLOW}[+] CONEXIONES ACTIVAS (ESTAB)${NC}"
sudo ss -tunap | grep ESTAB
echo

echo -e "${YELLOW}[+] DNS CONFIGURACIÓN${NC}"
cat /etc/resolv.conf
echo

echo -e "${YELLOW}[+] DNS TEST: Resolviendo google.com${NC}"
nslookup google.com
echo

echo -e "${YELLOW}[+] RESUMEN CONEXIONES POR IP (ESTAB)${NC}"
sudo ss -tunapH state established \
  | awk '{print $6}' \
  | sed 's/\[//g; s/\]//g' \
  | cut -d: -f1 \
  | sort | uniq -c | sort -nr | head -15
echo

echo -e "${BLUE}==================================="
echo "        FIN MINI SOC PERSONAL      "
echo "===================================${NC}"
