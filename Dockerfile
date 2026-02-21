# Dockerfile para rodar o Bootloader Real na VPS via QEMU
FROM debian:stable-slim

# Instala o QEMU para emular o hardware real
RUN apt-get update && apt-get install -y qemu-system-x86

WORKDIR /boot
COPY bootloader.bin .

# Exibe informações do binário
RUN ls -l bootloader.bin

# Comando para iniciar a emulação do hardware real
# -boot a: Força o boot pelo drive de disquete (mais confiável para binários de 512 bytes)
# -fda: Define o arquivo como o disquete A
CMD ["qemu-system-x86_64", "-fda", "bootloader.bin", "-boot", "a", "-nographic", "-serial", "mon:stdio"]
