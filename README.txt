A configuracao do firebase foi pela documentacao:
https://firebase.google.com/docs/flutter/setup?hl=pt-br&platform=ios#available-plugins

deu erro na Etapa 2: configurar os apps para usar o Firebase

RESOLUCAO:
Passo 1: Instale a CLI do FlutterFire
    dart pub global activate flutterfire_cli

Passo 2: Adicione a CLI do FlutterFire ao PATH
    dart pub global list

Passo 3: Execute o comando flutterfire configure
    flutterfire configure


Caso apresente o erro no MAIN (Undefined name 'Firebase)
Nas dependencias do projetos não está instaldo o "firebase_core"
Acesse > https://pub.dev/packages/firebase_core