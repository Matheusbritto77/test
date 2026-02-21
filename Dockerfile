# Dockerfile para rodar o Bootloader Real na VPS via QEMU
FROM debian:stable-slim

# Instala o QEMU para emular o hardware real
RUN apt-get update && apt-get install -y qemu-system-x86

WORKDIR /boot
COPY bootloader.bin .

# Exibe informações do binário
RUN ls -l bootloader.bin

# Expor a porta 80 para a Web
EXPOSE 80

# Comando para iniciar o servidor AlphaUnix com rede real
# -netdev user: Habilita o modo de rede do usuário
# -hostfwd=tcp::80-:80: Encaminha a porta 80 do Dokploy para a porta 80 do AlphaUnix
# -device e1000: Adiciona a placa de rede padrão da Intel
CMD ["qemu-system-x86_64", \
     "-drive", "file=bootloader.bin,format=raw,if=floppy", \
     "-boot", "a", \
     "-nographic", \
     "-serial", "mon:stdio", \
     "-netdev", "user,id=n1,hostfwd=tcp::80-:80", \
     "-device", "e1000,netdev=n1"]
