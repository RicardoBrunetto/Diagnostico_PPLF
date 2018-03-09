# Diagnóstico de Doenças - Paradigma Lógico
Este trabalho foi desenvolvido para a disciplina de Paradigma de Programação Lógica e Funcional (Ciência da Computação - UEM) em Setembro/2017 por Ricardo Henrique Brunetto (ra94182@uem.br)

## Funcionalidade
Este programa funciona com interface web escrita em GO no sistema operacional Windows.

Dessa forma, é necessário estar com o pacote da linguagem instalado no computador. [Disponível aqui](https://golang.org/).
Após instalá-la, basta abrir o `cmd` do Windows, navegar até a pasta `ws` e executar `go run template.go`.

O acesso pode ser feito em http://localhost:8080.

É necessário ter a suíte `SWI-Prolog` instalada e configuradas as variáveis de ambiente do Windows.

Em suma: a interface gráfica gera um arquivo `sintomas.txt` que é processado pelo programa escrito em Prolog, que gera um arquivo `output.txt` com o palpite de acordo com o *match* de sintomas.

## Especificações Tecnológicas
Todo o programa responsável pelo processamento fora escrito em Prolog. A interface gráfica fora escrita em Golang.
O programa em Prolog pode ser localmente executado no ambiente `SWI-Prolog`, visto que não há dependências externas que requeiram complexidade.

## Implementação
Uma apresentação geral do programa é feita [aqui](Apresentação.pdf). Não há documentação oficial. Dúvidas, entre em contato através do e-mail acima.

### Limitações e Sugestões
- Aperfeiçoar os palpites através da alimentação da base de dados.
- Corrigir bug na exibição do resultado (acontece aleatório).

## Licença
Este projeto segue a licença [Creative Commons Attribution-ShareAlike (BY-SA)](https://creativecommons.org/licenses/by-sa/4.0/), que está detalhada no arquivo [`LICENSE.md`](LICENSE.md).
<p align="center">
  <img src="https://licensebuttons.net/l/by-sa/3.0/88x31.png">
</p>
