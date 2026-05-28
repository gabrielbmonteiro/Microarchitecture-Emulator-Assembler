# Microarchitecture Emulator & Assembler (UFC2X) 💻🔌

Este repositório contém o projeto prático de simulação e emulação de hardware desenvolvido para a disciplina de **Arquitetura de Computadores** da Universidade Federal do Ceará (UFC). O projeto consiste no design e na implementação de uma microarquitetura microprogramada customizada (baseada no ecossistema UFC2X), o seu respetivo montador (*assembler*) e um conjunto de programas em linguagem de montagem (*Assembly*) de baixo nível para validação.

O núcleo do emulador foi otimizado integrando referências de design arquitetural, adaptando mapeamentos de controlo e lógica de execução.

---

## 🚀 Estrutura de Controlo e ISA Personalizado

O sistema opera sobre uma matriz de controlo microprogramada (Firmware). Conforme documentado, o conjunto de instruções da macroarquitetura (*Instruction Set*) e os seus opcodes foram remapeados estruturalmente para divergir e otimizar o comportamento padrão da CPU:

* **`add`**: `0x02` — Soma aritmética.
* **`sub`**: `0x0D` — Subtração aritmética *(Remapeado)*.
* **`mov`**: `0x06` — Movimentação/Cópia de dados entre registos *(Remapeado)*.
* **`goto`**: `0x09` — Desvio incondicional *(Remapeado)*.
* **`jz`**: `0x0B` — Desvio condicional se o resultado da ULA for zero (`if alu==0`) *(Remapeado)*.
* **`halt`**: `0xFF` — Interrupção/Paragem da execução.

### Otimizações no Microcódigo (Firmware)
As microinstruções em nível de firmware foram codificadas em formato binário de largura estendida para controlar os barramentos, operações da ULA e ciclos de memória de forma atómica. 

Exemplos de mapeamento de microinstruções implementados no emulador:
* **Passo 10/11 (Escrita em Memória):** `PC <- PC + 1; fetch; goto 11` -> `MAR <- MBR; goto 12` controlado via palavra binária de controlo dedicada (`0b000001011_...`).
* **Passo 15/272 (Desvio Condicional):** Avaliação de flag da ULA (`if alu=0 goto 272 else goto 16`) para ramificação de fluxo de microprograma.

---

## 📂 Arquitetura dos Ficheiros do Projeto

O ecossistema é modular e divide-se nas seguintes camadas:

* **`ufc2x.py`**: O coração do emulador. Simula a unidade de execução principal da CPU, a Unidade Lógica e Aritmética (ULA), o descodificador de instruções e o banco de registos internos (como os registos de dados e controlo `H`, `MAR`, `MDR`, `MBR`, `PC`).
* **`assembler.py`**: O montador do sistema. Lê código-fonte mnemónico (`.asm`), valida rótulos (*labels*), resolve pseudo-instruções de alocação de variáveis e gera o ficheiro binário executável (`.bin`) com os opcodes corretos.
* **`memory.py`**: Simulação física da memória de dados e de instruções. Providencia abstrações lógicas para leitura e escrita de palavras e bytes (`read_word`, `write_word`), gerindo o mascaramento e mapeamento de endereços de forma transparente.
* **`clock.py`**: Controla os ciclos de máquina e a sincronização temporal dos passos das microinstruções.
* **`disk.py` / `run_program.py`**: Módulos auxiliares de persistência e orquestração do ambiente de execução no terminal.

---

## 📜 Programas em Assembly Desenvolvidos

Para validar a corretude do processador emulado, foram escritos e testados três programas complexos em Assembly:

1.  **`potencia.asm` / `potencia.bin`**: Executa a função matemática de exponenciação ($x^n$) em tempo de execução através de loops iterativos baseados em subtrações e multiplicações estruturadas nos registos.
2.  **`fatorial.asm` / `fatorial.bin`**: Calcula o fatorial de um número ($n!$). Embora seja um problema classicamente recursivo, a rotina foi adaptada nativamente para uma lógica puramente iterativa devido às restrições físicas de stack da macroarquitetura.
3.  **`CSW.asm` / `CSW.bin`**: Implementação da rotina atómica **Compare-and-Swap** (CSW), essencial para sincronização em cenários concorrentes. A rotina valida a exclusão mútua em nível de hardware através da semântica:
    ```text
    if (a == c) {
        c = b;
        return 0;
    } else {
        a = c;
        return 1;
    }
    ```

---

## 🔧 Como Executar e Testar

### 1. Montar um programa Assembly
Para traduzir um código fonte `.asm` para o binário interpretável pela microarquitetura, executa o montador:
```bash
python assembler.py potencia.asm
```
Isto irá gerar o ficheiro compilado potencia.bin.

### 2. Executar o Emulador
Para carregar o binário compilado e simular o hardware executando as microinstruções passo a passo:
```bash
python run_program.py potencia.bin
