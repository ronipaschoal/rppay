# RP Pay

Aplicativo fictício de pagamentos desenvolvido como **estudo pessoal de Flutter e Inteligência Artificial**, com foco na aplicação de boas práticas de desenvolvimento, organização de código e construção de uma experiência próxima à de um aplicativo financeiro real.

> 🚧 **Projeto em desenvolvimento**
>
> Este projeto está sendo utilizado como laboratório para estudos de Flutter, arquitetura, gerenciamento de estado e utilização de IA durante o processo de desenvolvimento.

## 📱 Sobre o projeto

O aplicativo simula a experiência de um aplicativo de pagamentos, apresentando informações financeiras e funcionalidades comuns desse tipo de produto.

Atualmente, o projeto conta com:

* Splash Screen
* Home
* Visualização de saldo disponível
* Ações rápidas
* Informações do cartão
* Valor da fatura atual
* Histórico de transações
* Área de Pix
* Menu lateral (Drawer)

Novas funcionalidades e melhorias serão adicionadas conforme a evolução do estudo.

## 🖼️ Screenshots

### Home

![Home](docs/images/home.png)

### Pix

![Pix](docs/images/pix.png)

### Drawer

![Drawer](docs/images/drawer.png)

## 🏗️ Arquitetura

O projeto utiliza **MVVM (Model-View-ViewModel)** como referência arquitetural, buscando manter responsabilidades bem definidas entre apresentação, estado e regras da aplicação.

Também são aplicados alguns princípios do **SOLID**, principalmente com o objetivo de manter o código organizado, desacoplado e mais fácil de evoluir.

### Gerenciamento de estado

O gerenciamento de estado é realizado utilizando:

* **BLoC**
* **Cubit**

A escolha permite separar o estado e os eventos da camada de apresentação, mantendo os widgets mais focados na construção da interface.

## 📂 Estrutura do projeto

O projeto utiliza uma organização **Feature-First**, separando as funcionalidades da aplicação em módulos independentes.

```text
lib/
├── core/                                      # 🌐 Camada global e compartilhada
│   ├── constants/
│   │   └── app_colors.dart                    # Paleta de cores centralizada
│   │
│   ├── theme/
│   │   └── app_theme.dart                     # Configuração do ThemeData (Material 3)
│   │
│   └── widgets/
│       ├── custom_button.dart                 # Botão reutilizável com estado de loading
│       └── custom_drawer.dart                 # Menu lateral navegável
│
├── features/                                  # 📦 Módulos organizados por funcionalidade
│   │
│   ├── splash/                                # 🚀 Splash Screen
│   │   ├── cubits/
│   │   │   ├── splash_cubit.dart              # Gerenciamento do fluxo de inicialização
│   │   │   └── splash_state.dart              # Estados da Splash
│   │   │
│   │   └── views/
│   │       └── splash_view.dart                # Interface da Splash
│   │
│   ├── navigation/                            # 🧭 Navegação principal
│   │   ├── cubits/
│   │   │   ├── navigation_cubit.dart          # Gerenciamento da aba ativa
│   │   │   └── navigation_state.dart          # Estado da navegação
│   │   │
│   │   └── views/
│   │       └── main_navigation_view.dart       # Navegação principal
│   │
│   ├── home/                                  # 🏠 Dashboard / Home
│   │   ├── cubits/
│   │   │   ├── home_cubit.dart                # Estado e regras da Home
│   │   │   └── home_state.dart                # Estados da Home
│   │   │
│   │   ├── data/
│   │   │   ├── models/
│   │   │   │   └── home_data_model.dart       # Modelo dos dados da Home
│   │   │   │
│   │   │   └── repositories/
│   │   │       └── home_repository.dart        # Abstração e implementação dos dados
│   │   │
│   │   └── views/
│   │       └── home_view.dart                  # Interface da Home
│   │
│   └── pix/                                   # ⚡ Área Pix
│       ├── cubits/
│       │   ├── pix_cubit.dart                 # Estado e regras da área Pix
│       │   └── pix_state.dart                 # Estados do Pix
│       │
│       ├── data/
│       │   ├── models/
│       │   │   └── pix_action_model.dart       # Modelo das ações Pix
│       │   │
│       │   └── repositories/
│       │       └── pix_repository.dart         # Abstração e implementação dos dados
│       │
│       └── views/
│           └── pix_view.dart                   # Interface das ações Pix
│
└── main.dart                                  # 🎬 Ponto de entrada da aplicação
```

### Organização das camadas

A estrutura segue uma abordagem **Feature-First**, onde cada funcionalidade possui seus próprios componentes e regras.

* **`core/`** — concentra recursos compartilhados entre diferentes funcionalidades, como tema, constantes e widgets reutilizáveis.
* **`features/`** — agrupa as funcionalidades da aplicação, mantendo cada domínio isolado e facilitando sua evolução.
* **`cubits/`** — concentra o gerenciamento de estado e a lógica relacionada à apresentação.
* **`views/`** — contém as interfaces responsáveis pela apresentação dos dados e interação com o usuário.
* **`data/models/`** — contém os modelos utilizados para representar os dados de cada funcionalidade.
* **`data/repositories/`** — concentra a abstração do acesso aos dados, permitindo substituir posteriormente a fonte de dados sem impactar diretamente a camada de apresentação.

Essa organização busca favorecer **separação de responsabilidades, baixo acoplamento e facilidade de manutenção**, aplicando princípios do **SOLID** sempre que fizer sentido para o contexto da aplicação.

## 🛠️ Tecnologias

| Tecnologia       | Utilização                      |
| ---------------- | ------------------------------- |
| Flutter          | Framework principal             |
| Dart             | Linguagem                       |
| BLoC / Cubit     | Gerenciamento de estado         |
| MVVM             | Arquitetura                     |
| SOLID            | Princípios de design            |
| Gemini 3.6 Flash | Apoio ao desenvolvimento com IA |

**Flutter:** `3.44`

> TODO: adicionar demais bibliotecas e dependências utilizadas no projeto.

## 🤖 Inteligência Artificial

A **Inteligência Artificial faz parte do processo de desenvolvimento deste projeto**.

O **Gemini 3.6 Flash** foi utilizado como ferramenta de apoio durante o desenvolvimento, principalmente como recurso de estudo, exploração de alternativas e auxílio na implementação.

O objetivo não é apenas utilizar IA para gerar código, mas explorar como ferramentas de IA podem fazer parte do processo de desenvolvimento de software mantendo a responsabilidade técnica sobre as decisões e o código produzido.

> TODO: documentar exemplos de utilização da IA e decisões tomadas durante o desenvolvimento.

## 🚀 Como executar

### Pré-requisitos

* Flutter instalado
* Dart SDK compatível com a versão do Flutter utilizada
* Android Studio ou Xcode, caso deseje executar em dispositivos móveis

### Executando o projeto

Clone o repositório:

```bash
git clone https://github.com/ronipaschoal/rppay.git
```

Acesse o diretório:

```bash
cd rppay
```

Instale as dependências:

```bash
flutter pub get
```

Execute o aplicativo:

```bash
flutter run
```

## 🧪 Testes

> TODO: adicionar testes unitários, testes de widget e/ou testes de integração.

## 🔄 CI/CD

> TODO: configurar e documentar pipeline de CI/CD.

## 🌐 API e dados

Atualmente o projeto possui execução **local**, sem dependência de serviços externos.

> TODO: definir API utilizada e estratégia de comunicação com backend.

> TODO: definir estratégia de persistência/cache local.

## 💡 Decisões técnicas

> TODO: documentar as principais decisões arquiteturais e técnicas tomadas durante o desenvolvimento.

Alguns pontos que podem ser documentados futuramente:

* Motivos para utilização de MVVM
* Escolha de BLoC/Cubit
* Organização das features
* Estratégia de reutilização de componentes
* Separação de responsabilidades
* Tratamento de estados
* Estratégia de testes

## 🗺️ Roadmap

* [x] Definir e documentar estrutura de pastas
* [ ] Criar documentação dos requisitos
* [ ] Implementar camada de dados
* [ ] Definir API
* [ ] Implementar persistência local
* [ ] Adicionar testes unitários
* [ ] Adicionar testes de widget
* [ ] Adicionar testes de integração
* [ ] Configurar CI/CD
* [ ] Documentar decisões arquiteturais
* [ ] Adicionar novas funcionalidades
* [ ] Melhorar cobertura de testes
* [ ] Documentar utilização de IA

## 📚 Objetivo do estudo

Este projeto tem como objetivo explorar, na prática:

* Desenvolvimento de aplicações com Flutter
* Arquitetura MVVM
* Gerenciamento de estado com BLoC/Cubit
* Princípios SOLID
* Organização e escalabilidade de código
* Desenvolvimento de interfaces para aplicações financeiras
* Utilização de Inteligência Artificial no desenvolvimento de software
* Evolução incremental de uma aplicação Flutter

## 📌 Status

**Em desenvolvimento 🚧**

Este projeto é um laboratório pessoal e pode sofrer alterações de arquitetura, implementação e funcionalidades conforme novos conceitos forem estudados e aplicados.

---

## 👨‍💻 Autor

**Roni Paschoal**

Desenvolvedor de Software com experiência em desenvolvimento de aplicações utilizando Flutter e outras tecnologias para desenvolvimento de software.

[GitHub](https://github.com/ronipaschoal)

[LinkedIn](https://www.linkedin.com/in/roni-paschoal/)
