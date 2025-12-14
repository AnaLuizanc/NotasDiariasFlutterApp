# 📝 Notas Diárias App

Aplicativo Flutter para gerenciamento de anotações pessoais desenvolvido como projeto de conclusão da disciplina **Desenvolvimento em Dispositivos Móveis** ministrada pelos professores Paulo Augusto Borges de Matos e Wagner Jose dos Santos Junior.

## 🚀 Funcionalidades

- ✏️ **Criar anotações** com título e descrição
- 📖 **Visualizar anotações** em modo expandido
- 🔄 **Editar anotações** existentes
- 🗑️ **Excluir anotações** com confirmação
- 💾 **Persistência local** usando SQLite
- 🎨 **Interface intuitiva** e responsiva
- ⏰ **Data e hora** automáticas para cada anotação
- 🖼️ **Splash screen** personalizada

## 📱 Screenshots

### Tela Principal
Lista todas as anotações com data, título e prévia da descrição.

### Tela de Detalhes
Visualização completa da anotação com opções para editar ou excluir.

### Criação/Edição
Dialog intuitivo para adicionar novas anotações ou editar existentes.

## 🛠️ Tecnologias Utilizadas

- **Flutter** - Framework de desenvolvimento
- **Dart** - Linguagem de programação
- **SQLite** - Banco de dados local
- **sqflite** - Plugin para SQLite
- **path_provider** - Gerenciamento de caminhos de arquivos

## 📦 Dependências

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  sqflite: ^2.4.1
  path_provider: ^2.1.5
  path: ^1.8.3
```

## 🔧 Como Executar

### Pré-requisitos
- Flutter SDK instalado
- Android Studio ou VS Code
- Emulador Android ou dispositivo físico

### Passos para execução

1. **Clone o repositório**
```bash
git clone [URL_DO_REPOSITORIO]
cd notas_diarias_app
```

2. **Instale as dependências**
```bash
flutter pub get
```

3. **Execute o aplicativo**
```bash
flutter run
```

## 📱 Instalação do APK

Para gerar o APK de produção:

```bash
flutter build apk --release
```

O arquivo será gerado em: `build/app/outputs/flutter-apk/app-release.apk`

## 🏗️ Estrutura do Projeto

```
lib/
├── main.dart                 # Ponto de entrada da aplicação
├── SplashScreen.dart         # Tela de carregamento
├── MyHomePage.dart           # Tela principal com lista de anotações
├── DetalhesAnotacao.dart     # Tela de visualização detalhada
├── model/
│   └── Anotacao.dart         # Modelo de dados da anotação
├── helper/
│   └── AnotacoesHelper.dart  # Classe para operações no banco de dados
└── assets/
    └── img.png               # Imagem do splash screen
```

## 💾 Banco de Dados

O aplicativo utiliza SQLite para persistência local com a seguinte estrutura:

**Tabela: anotacoes**
- `id` (INTEGER PRIMARY KEY AUTOINCREMENT)
- `titulo` (VARCHAR)
- `descricao` (TEXT)
- `data` (DATETIME)

## 🎨 Design

- **Cores**: Esquema de cores baseado em roxo (#483D8B)
- **Material Design**: Interface seguindo diretrizes do Material 3
- **Responsivo**: Adaptável a diferentes tamanhos de tela

## 🔄 Funcionalidades Detalhadas

### Gerenciamento de Anotações
- **Criar**: Toque no botão "+" para adicionar nova anotação
- **Visualizar**: Toque em qualquer anotação da lista para ver detalhes
- **Editar**: Use o ícone de edição ou botão na tela de detalhes
- **Excluir**: Ícone de lixeira com confirmação de segurança

### Persistência de Dados
- Todas as anotações são salvas localmente no dispositivo
- Banco de dados criado automaticamente na primeira execução
- Operações CRUD completas (Create, Read, Update, Delete)

## 👨‍💻 Desenvolvedor

Desenvolvido por [Ana Luiza] como projeto acadêmico para a disciplina de Desenvolvimento em Dispositivos Móveis.

---

## 📄 Licença

Este projeto é um trabalho acadêmico e está disponível para fins educacionais.
