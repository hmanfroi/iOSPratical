#Sugestões de questões

1) Retain Cycle

- Retain cycle ao não utilizar [weak self] no método setupBinds da TaskListViewController    
- Retain cycle ao não utilizar [weak self] no diver no método start da MainCoordinator    
- É possível verificar como o candidato debuga para encontrar os cycles (adiciona deinit nas classes, se abre 
o debug memory graph)

2) ViewCode

- Na classe TaskTableViewCell podemos colocar um trailing com constante positiva, questionar como
seria possível ajuste o layout (colocando contante negativa ou invertendo a ordem das constrains)

3) Como otimizar o código?

- Adicionar final em classes para não serem extendidas 
- Adicionar private em métodos de classes

4) Camada de serviço

- Quebrar o contrato no tasks.json e verificar como é debugado para encontrar o bug 

5) Problema de: retain cicle ou método que não é chamado (no cenário atual não esta reproduzindo)

- No driver do TaskCoordinator, temos um problema que se utilizar [weak self] na lista de captura
o método initAddTask não é chamado pelo fato que o coordinator já saiu da memória, e ao adicionar initAddTask na lista de captura sem apontar para o disposeBag da viewController, o nosso TaskCoordinator
nunca é desalocado da memória.

6) Passagem dos valores entre viewModel e cell

- Vantagens e desvantagens do modelo atual
- Questionar como o candidato faria

7) Safe area no label do título na tela de adicionar tarefa

8) Como você faria a persistência dos dados
- Se espera uma resposta que usaria UserDefaults ou banco de dados.
- Perguntas: vantagens e desvantagens depedendo da resposta. 

9) Como trocar a cor da seleção da  célula. 

10) Qual responsabilidade do coordinator?

11) Como você faria o feed back de uma tarefa adicionada?

12) Foi modifcado na AddTaskViewModel quando adiciona outro elemento agora substitui. Objetivo é o candidato corrigir o teste unitário.

13) Simulador, *Quais features não consegue usar no simulador ou prefere usar um device real? 

14) Compilar o projeto *Quando o projeto não compila? 

15) Gerenciador de dependencia, Qual a diferença entre o cocoapods, carthage, e swift package manager? 

16)  Considerando que faz parte do dia a dia no desenvolvimento o surgimento de novos problemas para os quais não sabemos a resposta, qual é o seu procedimento para resolver este tipo de problemas? Como é o processo de busca de soluções para você? (Pergunta a colegas? Busca na internet? Etc.)

17) Quais arquiteturas tu conhece? Qual arquitetura você prefere?  Quais as vantagens e desvantagens.

18) O que é o Princípio da Inversão de Dependencia? (Dependency Inversion Principle — DIP)

19) Como tu julga o código que tu viu no teste? o que faria diferente?

20) Qual o maior desafio que tu já passou na tecnologia?
