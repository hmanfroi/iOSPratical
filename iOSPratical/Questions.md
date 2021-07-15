#Sugestões de questões

1) Retain Cycle

- Retain cycle ao não utilizar [weak self] no método setupBinds da TaskListViewController    
- Retain cycle ao não utilizar [weak self] no diver no método start da MainCoordinator    
- É possível verificar como o candidato debuga para encontrar os cycles (adiciona deinit nas classes, se abre 
o debug memory graph)

2) ViewCode

- Na classe TaskTableViewCell podemos colocar um trailing com constante positiva, questionar como
seria possível ajuste o layout (colocando contante negativa ou invertendo a ordem das constrains)

3) Como otimizar o código

- Adicionar final em classes para não serem extendidas 
- Adicionar private em métodos de classes

4) Camada de serviço

- Quebrar o contrato no tasks.json e verificar como é debugado para encontrar o bug 

5) Problema de: retain cicle ou método que não é chamado

- No driver do TaskCoordinator, temos um problema que se utilizar [weak self] na lista de captura
o método initAddTask não é chamado pelo fato que o coordinator já saiu da memória, e ao adicionar initAddTask na lista de captura sem apontar para o disposeBag da viewController, o nosso TaskCoordinator
nunca é desalocado da memória.

6) Passagem dos valores entre viewModel e cell

- Vantagens e desvantagens do modelo atual
- Questionar como o candidato faria

7) Safe area no label do título na tela de adicionar tarefa

8) Como você faria a persistência dos dados

9) Como trocar a cor da seleção da  célula. 

10) Qual responsabilidade do coordinator?
