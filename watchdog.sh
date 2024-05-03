#!/bin/bash

# Exemplo de chamada para o programa:
# ./watchdog.sh 8.8.8.8 5
# Isso fará com que o script pingue o endereço IP "8.8.8.8" a cada 5 segundos.

# Verifica se foram fornecidos argumentos suficientes
if [ $# -ne 2 ]; then
    echo "Uso: $0 <endereço_IP> <intervalo_ping>"
    exit 1
fi

# Atribui os argumentos fornecidos a variáveis
ping_address=$1
ping_interval=$2

# Configuração
error_count=0
max_errors=3

# Função para realizar o ping e verificar erros
perform_ping() {
    ping -c 1 $ping_address > /dev/null 2>&1
    return $?
}

# Loop infinito para realizar os pings
while true; do
    perform_ping

    # Verifica se houve erro no ping
    if [ $? -ne 0 ]; then
        ((error_count++))
        message="Erro no ping para $ping_address. Tentativa $error_count de $max_errors."
        logger -t watchdog_script "$message" # Redireciona para o syslog

        # Verifica se o limite de erros foi atingido
        if [ $error_count -ge $max_errors ]; then
            message="Limite de erros ($max_errors) atingido. Reiniciando o sistema..."
            logger -t watchdog_script "$message" # Redireciona para o syslog
            sudo reboot
            exit 0
        fi
    else
        error_count=0 # Reseta o contador se o ping for bem-sucedido
    fi

    sleep $ping_interval
done
