# Processador RISC-V Monociclo

O projeto consiste em uma descrição em Verilog de um processador RISC-V monociclo voltado para resolver o problema da Torre de Hanói de forma recursiva. O algoritmo em Assembly RISC-V pode ser encontrado em [algoritmo/hanoi.asm](algoritmo/hanoi.asm).

## Instruções implementadas

Apenas as instruções necessárias para rodar o algoritmo (com montagem feita através do RARS) foram implementadas nesse projeto. São elas:

- addi
- slli
- lw
- sw
- auipc
- jal
- jalr
- add
- beq

## Sobre o problema da Torre de Hanói

O problema da Torre de Hanói consiste em re-empilhar os discos de tamanhos diferentes da torre de origem na torre de destino, com a presença da torre auxiliar para ajudar nos movimentos. A principal regra é que os discos maiores não podem ficar acima de discos menores.

## Algoritmo

Inicialmente, o algoritmo foi implementado em Python ([algoritmo/hanoi.py](algoritmo/hanoi.py)), a fim de destrinchar o funcionamento lógico da resolução do problema.

Após isso, o algoritmo em Assembly foi escrito de forma a introduzir melhorias pontuais em relação ao algoritmo em Python:
- **Recursão na cauda:** Como a última camada de recursão não mexe na pilha, a implementação em Assembly evita metade das chamadas recursivas (e, em Python, o último nível chama duas vezes a função mover_disco).
- **Parâmetros em registradores:** Em Assembly, os pinos são gerenciados pelos registradores `s0-s5`, alterando apenas a ordem de seus conteúdos em cada camada. Já em Python, mais memória deve ser alocada a cada recursão para guardar os valores. Com isso, a cada camada, apenas 8 bytes são alocados, o `ra` e o `n`. Isso só é possível porque cada troca, na volta da recursão, é desfeita fazendo a troca inversa.
- **Vetores fixos**: Em Python, as operações de manipulação de lista são mais custosas pois envolvem busca de métodos, contagem de referências, verificação de limites e, às vezes, realocação de lista. Esse ponto, especificamente, seria minimzado se fosse utilizada outra linguagem, como C. De qualquer forma, a implementação em Assembly se sai melhor que as realizadas em ambas as linguagens.

Apesar disso, sabe-se que a implementação não é perfeita, havendo ainda possibilidade de melhorias, sendo a principal delas:

- Agora, antes da segunda chamda recursiva, é realizada a troca inversa (para obter o estado da camada de recursão atual) e depois mover é chamada, realizando uma quantidade significativa de trocas desnecssárias ao invés de fazer uma rotação das 3 torres de forma direta. O motivo dessa melhoria não ter sido realizada é que ela tornaria o código Assembly menos legível, fugindo do intuito da construção desse projeto.

## Como visualizar?

Antes de começarmos, verifique se os programas Icarus Verilog e GTKWave estão instalados na sua máquina. Além disso, não é necessário montar o código com RARS, os dumps das memórias estão na pasta [/memory](/memory), sendo `instr.hex` o da memória de instruções e `data.hex` o da memória de dados.

Agora, execute o seguinte comando para gerar o binário com o Icarus Verilog.

```bash
iverilog -o cpu_sim tb_cpu.v
```

Após isso, rode o seguinte para gerar o .vcd para alimentar o GTKWave. Além disso, o comando seguinte exibe informações acerca do resultado do processamento do algoritmo.

```bash
vvp cpu_sim
```

O output esperado é:

```
1: WARNING: ./instr_mem.v:7: $readmemh(memory/instr.hex): Not enough words in the file for the requested range [0:255].
2: WARNING: ./data_mem.v:9: $readmemh(memory/data.hex): Not enough words in the file for the requested range [0:2047].
3: VCD info: dumpfile cpu.vcd opened for output.
4: origem   = 1 2 1
5: destino  = 3 2 1
6: auxiliar = 2 1 0
7: topos: s1=-1 s3=2 s5=-1 | sp=00003ffc | PC=00000030
8: tb_cpu.v:26: $finish called at 3008 (1s)
```

> As linhas `4-7` exibem o estado atual de cada torre. Perceba que as torres `origem` e `auxiliar` ainda possuem valores. Esse comportamento não é um erro, e sim decorrente da forma que o algoritmo funciona, controlando o índice de topo das torres com os registradores `s1`, `s3` e `s5`. Dessa forma, perceba que, na linha `7`, os índices armazenados em `s1` e `s5` são iguais a -1, indicando que as torres estão vazias (não possuem discos).

Por fim, para visualizar a *testbench* no visualizador de ondas:

```bash
gtkwave cpu.vcd
```
