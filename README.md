# fin_track

Flutter Finances Management App com sqflite, provider, get_it and ChangeNotifier.<br/>
E alguns testes de segurança.



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

 Nos arquivos em `smali` podemos ver o mesmo que alguém que tente fazer engenharia reversa vê no nosso código, repare no nome das classes como a / a1, ao invés dos nomes declarativos, que poderiam ser facilmente compreendidos por engenharia reversa.<br/>

### RootChecker
Adicionando funcionalidade nativa em kotlin que verifica se o dispositivo está rootado analisando arquivos suspeitos, comandos shell (su, magisk) e propriedades do sistema. Se detectar root, fecha o app imediatamente.<br/>
`android/app/src/main/kotlin/com/example/fin_track/RootChecker.kt`

### HooksChecker
Adicionando funcionalidade nativa em kotlin que detecta a presença de ferramentas de hooking (ex: Frida, Shadow, entre outros) analisando processos em execução, injeção de código (/proc/self/maps) e manipulação de memória. Se um ataque for identificado, fecha o app imediatamente.<br/>
`android/app/src/main/kotlin/com/example/fin_track/HooksChecker.kt`

### EmulatorChecker
Verifica se o app está rodando em um emulador, analisando características do dispositivo, como modelo, fabricante, hardware e presença de sensores físicos. Se detectar um ambiente de emulação, o app é encerrado para evitar execuções indesejadas.<br/>
`android/app/src/main/kotlin/com/example/fin_track/EmulatorChecker.kt`

### MainActivity
```kotlin
class MainActivity : FlutterActivity(){
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
          RootChecker.checkRootAndExit(this) //verifica se é root
          HooksChecker.checkHookingAndExit(this) //verifica se possui algum hook
          EmulatorChecker.checkEmulatorAndExit(this) // verifica se está rodando em dispositivo físico
    }
}
```
### Frida

### Download frida-server
Download [frida-server](https://github.com/frida/frida/releases), procure por `frida-server-XX.X.X-android-arm64.xz`, para dispositivos mais modernos.<br/>

Extraia o arquivo e renomeie ele para `frida-server` apenas, não se preocupe se reclamar da extensão, caso esteja no windows ele reclamará isso, mas está tudo certo, aceite e prossiga.<br/>

### Transferindo para o android
Com seu celular conectado via usb vamos enviar nosso arquivo `frida-server` para `/data/local/tmp/` com o seguinte comando<br/>

`adb push frida-server /data/local/tmp/` onde frida-server pode ser o caminho em que está o arquivo frida-server.<br/>
Resultado deve ser algo como:<br/>
```shell
PS C:\projetos\fin_track> adb push C:\src\frida\frida-server /data/local/tmp/
C:\src\frida\frida-server: 1 file pushed, 0 skipped. 104.0 MB/s (56875320 bytes in 0.522s)
```
Acesse o shell do ADB<br/>
`adb shell`<br/>

Dê permissão de execução e inicie o frida-server:<br/>
`cd /data/local/tmp/`<br/>
`chmod +x frida-server`<br/>
`./frida-server &`<br/>

A partir dai o frida-server estará rodando em background e te exibira um pID de resposta como `[1] 31977`<br/>

Após a instalação do frida, perceba que a função `HooksChecker.kt` não nos deixa mais rodar o aplicativo, como era de se esperar, pois o frida está instalado no nosso dispositivo.<br/>

Para corrigir isso remova o `frida-server` de `/data/local/tmp/`<br/>

`adb shell`<br/>
`cd /datalocal/tmp/`<br/>
`ls`<br/>
`rm -rf frida-server*`<br/>


