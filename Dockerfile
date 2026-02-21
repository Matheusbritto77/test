# Dockerfile para rodar o Bootloader Real na VPS via QEMU
FROM debian:stable-slim

# Instala o QEMU para emular o hardware real
RUN apt-get update && apt-get install -y qemu-system-x86

WORKDIR /boot
COPY bootloader.bin .

# Exibe informações do binário
RUN ls -l bootloader.bin

# Comando para iniciar a emulação do hardware real
# -drive: Define o binário como o disco rígido principal
# -display none: Remove a necessidade de interface gráfica na VPS
# -serial stdio: Redireciona a entrada/saída serial para o console do Docker
CMD ["qemu-system-x86_64", "-drive", "format=raw,file=bootloader.bin", "-nographic", "-serial", "mon:stdio"]
