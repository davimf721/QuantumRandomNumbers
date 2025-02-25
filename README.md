# Quantum Random Number Generator
Este projeto demonstra a geração de números aleatórios verdadeiros usando computação quântica. O programa utiliza qubits , a unidade básica de informação quântica, para gerar números aleatórios e convertê-los para decimal.

## O que este programa faz?
O programa implementa um gerador de números aleatórios quânticos . Ele coloca qubits em superposição, mede seus estados e converte os resultados binários para um número decimal. Cada execução gera um número aleatório único, explorando as propriedades da mecânica quântica.

## Como funciona?
### 1. Bits vs Qubits <br>
- Bits clássicos : Um bit pode estar em um dos dois estados: `0` ou `1`. Ele é determinístico, ou seja, sempre tem um valor fixo.
- Qubits (bits quânticos) :
  - Um qubit pode estar em uma superposição de `0` e `1`, representando ambos os estados simultaneamente.
  - Quando medido, o estado do qubit "colapsa" para `0` ou `1` com probabilidades determinadas pela superposição.
  - Essa propriedade permite gerar números aleatórios verdadeiros, ao contrário dos geradores pseudoaleatórios clássicos.

### 2. Passos do Programa
- Inicialização : Aloca-se um conjunto de qubits inicializados no estado ∣0⟩.
- Superposição : Aplica-se a porta Hadamard (H) para colocar cada qubit em superposição, criando uma distribuição uniforme entre ∣0⟩ e ∣1⟩.
- Medição : Mede-se cada qubit, colapsando seu estado para `0` ou `1`.
- Conversão : Os bits medidos são interpretados como um número binário e convertidos para decimal.

  ## Requisitos
Para executar este programa, você precisará das seguintes ferramentas instaladas:

1)  .NET SDK :<br>
  O Microsoft Quantum Development Kit (QDK) depende do .NET SDK.
  Instale-o seguindo as instruções oficiais para sua distribuição Linux:
  https://learn.microsoft.com/en-us/dotnet/core/install/linux
2) Microsoft Quantum Development Kit (QDK) : <br>
  Instale o python 3, em seguida use o comando:
```bash
python -m pip install qsharp azure-quantum

```
é necessario ter o VSCode com as extensões Python, Jupyter e **Azure Quantum Development Kit (QDK)**.

## Como rodar o programa
### Passo 1: Clone o repositório
Se você já tem o código, pule para o Passo 2. Caso contrário, clone o repositório contendo o programa:

```bash
git clone https://github.com/davimf721/QuantumRandomNumbers.git
```

### Passo 2:
rode o programa com o VSCode runner.

## Saída esperada
Cada execução gera um número aleatório decimal. Por exemplo:
```bash
Decimal value: 10
```

## Explicação do Código
### Função Principal (`Main`)
```qsharp
@EntryPoint()
operation Main() : Unit {
    use register = Qubit[4];
    
    // Coloca os qubits em superposição
    for qubit in register {
        H(qubit);
    }
    
    // Mede os qubits e os reseta
    let results = MResetEachZ(register);
    
    // Converte os bits medidos para decimal
    let decimalValue = ResultArrayAsInt(results);
    Message($"Decimal value: {decimalValue}");
}

```
- Aloca 4 qubits.
- Aplica a porta Hadamard (`H`) para criar superposição.
- Mede os qubits e converte os resultados para decimal.
  ### Função Auxiliar (`ResultArrayAsInt`)
  ```qsharp
  function ResultArrayAsInt(results : Result[]) : Int {
    mutable value = 0;
    for idx in 0..Length(results) - 1 {
        if results[idx] == One {
            set value += 2^(Length(results) - 1 - idx);
        }
    }
    return value;
  }
  ```

- Converte um array de bits (`Zero` ou `One`) para um número decimal.

  ## Por que usar qubits?
Os qubits diferem dos bits clássicos por suas propriedades únicas:

1) Superposição :
- Um qubit pode estar em múltiplos estados simultaneamente, permitindo processamento paralelo.
- Isso é usado aqui para gerar números aleatórios verdadeiros.
2)  Entrelaçamento :
- Qubits podem ser entrelaçados, criando correlações instantâneas entre eles, mesmo à distância.
3) Aleatoriedade Inerente :
- A medição de um qubit em superposição resulta em um valor aleatório (`0` ou `1`), explorado neste programa.
4) se quiser aprender um pouco mais sobre computação quantica:
- https://quantum.country/qcvc#part-I
- https://learn.microsoft.com/pt-br/training/modules/intro-to-azure-quantum/2-what-is-quantum-compute
- http://qubitfactory.io/

## Conclusão
Este programa é uma introdução prática à computação quântica, demonstrando como gerar números aleatórios verdadeiros usando qubits. Ele é ideal para iniciantes que desejam entender os conceitos básicos de qubits e experimentar um exemplo simples de programação quântica.

Se você tiver dúvidas ou sugestões, sinta-se à vontade para abrir uma issue no repositório!







