#!/usr/bin/env bash
set -e # Interromper em caso de erro

# 1. Instalar o Flutter se não existir
if [ ! -d "flutter" ]; then
  echo "Clonando Flutter SDK..."
  git clone https://github.com/flutter/flutter.git -b stable --depth 1
fi

# 2. Adicionar ao PATH
export PATH="$PATH:$(pwd)/flutter/bin"

# 3. Rodar o setup
flutter doctor -v

# 4. Habilitar Web
flutter config --enable-web

# 5. Instalar dependências e Build
flutter pub get
flutter build web --release
