# Watchdog Script

Este é um script em bash para monitorar a conectividade de rede através de pings periódicos para um determinado endereço IP. Se ocorrerem erros consecutivos de ping, o script reiniciará o sistema.

## Funcionalidades

- Realiza pings periódicos para um endereço IP especificado.
- Reinicia o sistema se houverem três erros consecutivos de ping.
- Registra todas as atividades no syslog do sistema.

## Utilização

Para utilizar o script, siga os passos abaixo:

1. Execute o script com permissões de superusuário (sudo) e forneça dois argumentos:
   - O endereço IP que você deseja monitorar.
   - O intervalo de ping em segundos.

Exemplo de chamada:
sudo ./watchdog.sh 8.8.8.8 5

