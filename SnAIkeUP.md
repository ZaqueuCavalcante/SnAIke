# SnAIke Game

**Pensando sobre o problema**:
- Ter em mente que a cada movimento que a cobra faz, o grafo se modifica;
- Logo, as melhores opções mudam a cada movimento;
- Assim, tomar sempre as melhores opções no momento podem levar a um game over no futuro?
- E o que parece um game over agora, uma situação sem saída, pode ser contornada mais a frente? (Sim!)

**Ideias de solução**:
- Usar um algoritmo de Pathfinding pra achar o caminho mais curto até a comida:
    - Dijkstra's, A*, Bellman–Ford...
- Após isso, achar um caminho que conecte a comida ao rabo da cobra, sem interceptar o caminho que vai da cabeça da cobra até a comida, é claro;
- A junção [cobra + caminho da cabeça da cobra até a comida + caminho da comida até o rabo da cobra] formaria um ciclo;
- Basta que a cobra se mantenha sempre seguindo esse ciclo até o final do jogo;

**Design do game**:
- Fazer o jogo ser independente do que/de quem vai jogá-lo:
    - No domínio do jogo, não importa se é um humano, algoritmo de pathfinding ou rede neural que vai controlar a cobra;
    - As regras de negócio devem estar separadas de todo o resto;
    - Expor apenas interfaces para controle da cobra e métodos para acessar dados do jogo, sem modificá-los;
- Usar a biblioteca gráfica como uma camada burra do sistema:
    - Ela sabe apenas receber objetos e os mostrar na tela, nada além disso;
    - Não deve haver nenhuma regra de como o jogo funciona nela;
- Abordagem de ports and adapters:
    - Fazer os módulos de alto nível do jogo dependerem de abstrações, não de implementações;
    - Usar herança, interfaces e polimorfismo para poder plugar e desplugar facilmente um módulo/recurso do outro;
    - Nesse sentido, seria possível iniciar o jogo com um humano jogando e fazer um switch para que um algoritmo passasse a controlar a cobra, em tempo de execução;
- A entidade base de todo o jogo é o Node:
    - Ele possui alguns atributos fundamentais, como:
        - Posição (x, y);
	    - Tamanho;
	    - Lista de Nodes que ele pode acessar diretamente;
    - Os seguintes atores são formados por Nodes ou são especializações de um:
        - O Cenário é um grafo de Nodes;
        - A Cobra é uma lista ligada de Nodes;
        - A comida, um obstáculo e um portal são extensões de um Node, com alguns atributos e métodos a mais;
- Alternativamente, poderíamos criar um único grafo e fazer cenário, cobra, comida, obstáculo e portal armazenarem apenas referências para os nós do grafo;

**Adição de features**:
- Fazer uma cobra competir com outra pela mesma comida, num mesmo jogo;
- Colocar obstáculos dentro do cenário, uma espécie de labirinto;
- Fazer a comida 'fugir' da cobra. Ela poderia se mover aleatoriamente ou ser controlada por um player humano ou um algoritmo;
- Um portal ou buraco de minhoca, que conecta dois nós distantes do grafo:
    - Um Plot Twist, semelhante ao aviãozinho no vídeo do Dinossauro do Google;
    - A cobra teria uma Portal Gun, que poderia usar para contornar situações difíceis no game;
    - Ela seria recarregada a cada x maçãs comidas;
    - Evitaria colisão com próprio corpo, parede ou obstáculo;
    - Ele se fecha quando a cobra o atravessa completamente;
    - Animação do portal, igual o do Rick and Morty;
    - Alterar a cor dos olhos da cobra, pra mostrar que a opção de invocar portais está disponível;
- Cobra com duas cabeças:
    - Ela pode usar uma das cabeças pra se mover, vai depender de qual delas está mais perto da comida;
- Comidas com diferentes 'valores nutricionais':
    - O corpo da cobra cresceria mais ou menos, dependendo do tipo de comida;
- Comidas bônus por tempo limitado, com 'valores nutricionais' mais altos;


**Conteúdos a serem abordados**:
- Princípios de Design Orientado a Objetos;
- Modelagem de Software;
- Diagramas UML;
- SOLID;
- Clean Code;
- Refatoração;
- Design Patterns;
- Algoritmos de Busca em Grafos;
- Estruturas de Dados;
- Programação paralela;

**Tópicos avulsos**:
- Fazer análises estatísticas detalhadas para cada configuração de cenário e métodos de solução?
- Fazer o projeto em formato de série, com vídeos relativamente curtos?
- Tonar o código aberto?
- Implementação e documentação em inglês?
- Legendar os vídeos para maior alcance?


Obviamente, tudo que descrevi acima são apenas sugestões e ideias iniciais.
Qualquer um que se interessar pode contribuir com mais ideias, sugestões, código, tradução... Seria extremamente gratificante pra mim.
Enfim, queria saber a opinião de vocês sobre o projeto.
