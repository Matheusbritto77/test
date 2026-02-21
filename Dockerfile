# Dockerfile para rodar o Bootloader Real na VPS via QEMU
FROM debian:stable-slim

# Instala o QEMU para emular o hardware real
RUN apt-get update && apt-get install -y qemu-system-x86

WORKDIR /boot
COPY bootloader.bin .

# Exibe informações do binário
RUN ls -l bootloader.bin

# Comando para iniciar a emulação do hardware real
# -drive: Define explicitamente o formato raw para evitar o aviso e restrições do Probing
# -net none: Remove o iPXE e placa de rede, forçando o BIOS a focar no disco/disquete
# -boot order=a: Garante que o disquete A seja a primeira e única opção de boot
CMD ["qemu-system-x86_64", "-drive", "file=bootloader.bin,format=raw,if=floppy", "-boot", "order=a", "-nographic", "-serial", "mon:stdio", "-net", "none"]
