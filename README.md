## 0.1.0.1

# README - Pratic Fit Backend

## Overview

Pratic Fit Backend é um projeto que fornece dados e recursos para o Pratic Fit App. Ele foi desenvolvido em Dart e é compatível com sistemas operacionais Ubuntu. Este README contém informações importantes sobre como configurar e executar o projeto.

## Setup

Antes de executar o projeto, certifique-se de ter o Dart instalado em sua máquina e ter os arquivos `.env` e `.env.dev` preenchidos com as seguintes informações: `JWT_KEY=` e `DATABASE_URL`. Para instalar as dependências, execute o seguinte comando no console:

```sh
dart pub get
```

## Deployment

Ao subir o projeto para um servidor Ubuntu, é importante não incluir os seguintes arquivos: `.gitgnore`, `.vscode` e `.dart_tool`. Quando os arquivos já estiverem no servidor, siga os passos abaixo:

1. Execute o seguinte comando para instalar as dependências:

```sh
dart pub get
```

2. Compile o projeto localmente com o seguinte comando:

```sh
dart compile exe bin/PraticFitBackend.dart -o main
```

3. Para executar o projeto, utilize o seguinte comando:

```sh
./main
```

## Conclusion

Este README fornece informações importantes para configurar e executar o Pratic Fit Backend com segurança e eficiência. Se você tiver alguma dúvida, não hesite em entrar em contato com a equipe de desenvolvimento.
