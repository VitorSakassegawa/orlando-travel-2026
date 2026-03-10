#!/usr/bin/env bash
set -ex # Mostra comandos e para em erro

echo "--- INICIANDO BUILD FLUTTER ---"
echo "Diretório atual: $(pwd)"
ls -la

# 1. Instalar o Flutter se não existir
if [ ! -d "flutter" ]; then
  echo "Clonando Flutter SDK (branch stable)..."
  git clone https://github.com/flutter/flutter.git -b stable --depth 1
fi

# 2. Adicionar ao PATH de forma absoluta
FLUTTER_PATH="$(pwd)/flutter/bin"
export PATH="$PATH:$FLUTTER_PATH"

echo "Verificando se o comando flutter existe..."
which flutter || (echo "ERRO: Comando flutter não encontrado no PATH" && exit 1)

# 3. Rodar o setup
flutter --version

# 4. Habilitar Web e Configurar Projeto
flutter config --enable-web
echo "Configurando projeto para Web..."
flutter create . --platforms web

# 5. Instalar dependências e construir
echo "Rodando flutter pub get..."
flutter pub get

echo "Rodando flutter build web..."
flutter build web --release

echo "--- BUILD FINALIZADO COM SUCESSO ---"
ls -la build/web
