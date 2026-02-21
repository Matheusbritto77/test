# Dockerfile para rodar o Bootloader Real na VPS via QEMU
FROM debian:stable-slim

# Instala o QEMU para emular o hardware real
RUN apt-get update && apt-get install -y qemu-system-x86

WORKDIR /boot
COPY bootloader.bin .

# Exibe informações do binário
RUN ls -l bootloader.bin

# Comando para iniciar a emulação do hardware real
# -drive: Define explicitamente o formato raw e interface floppy
# -serial mon:stdio: Combina o monitor do QEMU e a porta serial em um único fluxo (evita o erro)
CMD ["qemu-system-x86_64", "-drive", "file=bootloader.bin,format=raw,if=floppy", "-boot", "a", "-nographic", "-serial", "mon:stdio"]
