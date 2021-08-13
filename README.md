# LuizaLabs

## **Arquitetura**

Escolhi a arquitetura clean architecture com o pattern composition roots. Nessa arquitetura eu ganho alta testabilidade, escalabilidade e a possibilidade de aplicar as boas práticas do SOLID.

O App está desenhado em 6 layer. As layers são main, ui, presentation, domain, data e infra.

Main é a layer onde é aplicado o composition roots, essa layer faz a composição de todos as outras layers e por conta disso é camada que depende de todas as outras.

UI layer é responsável pelo layout, aqui ficam as view controllers, essa camada é totalmente desacoplada das outras.

Presentation é a camada que é responsável pelas regras de negócios. Essa tem dependência com a domain

Domain é a camada onde ficam os protocolos dos casos de uso. Não depende de outra camada

Data é a camada que implementa os use cases da domain. 

Infra é a camada onde ficam os frameworks externos. Dessa forma é possível isolar as outras camadas da aplicação que ficam com as regras do negócio. 

Cada layer é um target, tomei essa decisão pois dessa forma eu consigo garantir que cada camada só irá acessar a camada que deveria, porque é preciso manualmente adicionar suas dependências. Além disso, os testes ficam mais rápidos, pois irá rodar apenas os testes da camada que está selecionada. Em contra partida, o setup fica maior.

Existem dois schemas adicionais no projeto, chamados CI e UseCaseIntegrations

CI -> é o schema que faz o build de todas as layers e também roda os testes de todas as camadas.

UseCaseIntegration -> é um target de testes end to end

## **Gerenciador de dependências:**

Escolhi o cocoapods, pois é o gerenciador de pacotes que eu tenho mais afinidade. Pensei em utilizar o swift package manager, mas tem um biblioteca que eu usei em específico que não suporta o swift package manager, então segui com o cocoapods.

## **Frameworks utilizados**

Utilizei dois frameworks:

Alamofire
NimbleSnapshot

Comecei a implementar utilizando URL Session, pois hoje em dia bem fácil trabalhar com essa API, mas decidi experimentar o alamofire que é um framework bastante popular. Além do que, caso no futuro precise trocar o alamofire por outro framework, essa mudança não teria muito custo, dado que as regras de negócio não dependem diretamente do alamofire e sim de um interface que é estável.

NimbleSnapshot é um framework que dá possibilidade de testar o layout sem precisar escrever testes de UI. Um teste não substitui o outro, mas eu tenho alguns ganhos com essa biblioteca, porque ele roda como teste unitário, é super rápido e fácil de utilizar. Além de garantir que o meu layout esteja conforme esperado tanto nos iphones grandes, quanto nos pequenos.

observação sobre o testes de snapshots:  para os testes de snapshots feitos no projeto passarem é preciso rodá-los com o simulador do iphone 8, pois esse framework exige que um simulador seja default. No caso eu escolhi o iphone 8.

## **Taxa de cobertura dos testes, segundo o xcode**

Presentation - 100% \
Data - 100% \
Domain - 100% \
Infra - 100% \
UI - 64,8% \
Main - 67.7% \

\ \
As camadas Main e UI foram testados tudo que eu julguei relevante, mas ficaram algumas coisas de fora, principalmente que fazem uso do UIKIT, mas nada que tenha lógica para ser testada.


## **Como instalar o app**

1. Clonar o projeto
2. instalar o cocoapods, caso não tenha instalado.
3. abrir o arquivo LuizaLabs.xcworkspace
4. buildar o target main
5. importante app desenvolvido no xcode 12 e como essa versão do cocoapods 1.10.1 versão do cocoapods.

Para rodar todos os teste, selecione o schema CI e rode os testes com o iphone 8 selecionado para garantir que os testes de snapshot também passem.
