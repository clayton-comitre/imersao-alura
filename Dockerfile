# 1. Usar uma imagem oficial do Python como base.
# O readme menciona Python 3.10+, então usaremos uma versão recente e estável.
# A variante 'slim' oferece um bom equilíbrio entre tamanho e ferramentas necessárias.
FROM python:3.11-slim

# 2. Definir o diretório de trabalho dentro do contêiner.
WORKDIR /app

# 3. Copiar o arquivo de dependências primeiro para aproveitar o cache de camadas do Docker.
COPY requirements.txt .

# 4. Instalar as dependências.
# --no-cache-dir reduz o tamanho da imagem, e atualizar o pip é uma boa prática.
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# 5. Copiar o restante do código-fonte da aplicação para o contêiner.
COPY . .

# 6. Expor a porta em que a aplicação será executada.
EXPOSE 8000

# 7. Definir o comando para executar a aplicação quando o contêiner iniciar.
# Usamos 0.0.0.0 para tornar a aplicação acessível de fora do contêiner.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]
