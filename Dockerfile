# Dockerfile para rodar o Bootloader Real na VPS via QEMU
FROM debian:stable-slim

# Instala o QEMU para emular o hardware real
RUN apt-get update && apt-get install -y qemu-system-x86

WORKDIR /boot
COPY bootloader.bin .

# Exibe informações do binário
RUN ls -l bootloader.bin

# Comando para iniciar a emulação do hardware real
# -fda: Força o uso do arquivo como disquete A (Drive 0)
# -boot a: Força o BIOS a tentar o disquete primeiro
# -nographic e -serial: Para vermos a saída no log da VPS
CMD ["qemu-system-x86_64", "-fda", "bootloader.bin", "-boot", "a", "-nographic", "-serial", "mon:stdio"]
