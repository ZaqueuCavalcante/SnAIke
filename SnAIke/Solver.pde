public interface Solver {

  // Interface para padronizar a iteração entre os métodos de solução 
  // e o controle da cobra.
  // Métodos a serem implementados:
  //   - Neural Network (Multilayer Perceptron) + Genetic Algorithms;
  //   - Ciclo Hamiltoniano;
  //   - Reforce Learning;
  
  void receberDadosDoRadar();
  void realizarProcessamento();
  void dizerPraCobraOQueFazer();  // Ir pra esquerda, frente ou direita ?

}
