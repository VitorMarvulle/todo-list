#!/usr/bin/env bash

# Fail on errors
set -e

# Echo commands to the terminal output
set -x

# Configurar permissões para scripts
chmod +x bin/*

# Instalar dependências, ignorando grupos desnecessários
bundle install --without development test

# Pré-compilar assets para produção
echo "Precompiling assets..."
bin/rails assets:precompile || echo "Asset precompilation failed. Skipping."

# Iniciar o servidor Rails
echo "Starting Rails server..."
bin/rails server -b 0.0.0.0 -p $PORT
