# fin_track




A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.



## Security
Depois de configurar o proguard. <br/>
Faça o download [apktool](https://apktool.org/docs/install) e siga a instruções<br/>
caso o comando `apktool` não funcione, mesmo você tendo acesso a Windows/ ou tenha instalado em outra pasta, tente `java -jar C:\<seu-caminho>\apktool.jar`.<br/>

Para extrair as informações do apk, primeiro gere uma release.<br/>
`flutter run --release` ou `flutter build apk --release` <br/>

Agora rode o comando de dentro do seu projeto, para que os caminhos se mantenham os mesmos, `apktool d build\app\outputs\flutter-apk\app-release.apk -o apktool_data\`, a pasta `apktool_data` é gerada automaticamente, não é necessário cria-la antes.<br/>

Agora nos arquivos gerados em `apltool_data/` você pode ver o que foi descompilado do apk: <br/>
 - AndroidManifest.xml: O arquivo de manifesto que descreve a estrutura do aplicativo.
 - res/: Pasta contendo todos os recursos (layouts, strings, imagens, etc.).
 - smali/: Pasta com o código Smali, que é uma representação intermediária do código DEX (Dalvik Executable). Este é o código compilado em bytecode.<br/>

 Nos arquivos em `smali` podemos ver o mesmo que alguém que tente fazer engenharia reversa vê no nosso código, repare no nome das classes como a / a1, ao invés dos nomes declarativos, que poderiam ser facilmente compreendidos por engenharia reversa.


