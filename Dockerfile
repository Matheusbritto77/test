# Dockerfile para rodar o Bootloader Real na VPS via QEMU
FROM debian:stable-slim

# Instala o QEMU para emular o hardware real
RUN apt-get update && apt-get install -y qemu-system-x86

WORKDIR /boot
COPY bootloader.bin .

# Exibe informações do binário
RUN ls -l bootloader.bin

# Comando para iniciar a emulação do hardware real
# -fda: Define o arquivo como disquete A
# -boot a: Prioridade total para o disquete
# -nographic e -serial: Para ver nos logs do Dokploy
CMD ["qemu-system-x86_64", "-fda", "bootloader.bin", "-boot", "a", "-nographic", "-serial", "mon:stdio"]
