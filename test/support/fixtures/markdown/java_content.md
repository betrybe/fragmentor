## Java Example

Perceba que a instrução `System.out.println()` gera uma saída de texto, criando uma nova linha e posicionando o cursor na linha abaixo, o que é identificado pela terminação "ln". 
No exemplo abaixo, passamos a string que será impressa na saída do console quando executarmos nosso programa Java. Podemos ver que serão impressas duas linhas com esse trecho de código. Se você clicar no console verá que o cursor estará na linha abaixo da frase "Segunda Linha".

```java
public class HelloWorld {
	public static void main(String[] args) {
		System.out.println("Primeira Linha");
		System.out.println("Segunda Linha");
	}
}
```

Por outro lado, a instrução `System.out.print()`, se você observar, não possui o "ln", por isso exibe uma String sem criar uma nova linha, deixando o seu cursor na mesma linha. Execute essa alteração no código e veja que as duas frases foram impressas na mesma linha.

```java
public class HelloWorld {
	public static void main(String[] args) {
		System.out.print("Primeira Linha");
		System.out.print("Será impresso também na primeira linha");
	}
}
```

Esses dois métodos são muito úteis quando estamos escrevendo programas em Java porque podemos ir imprimindo valores e mensagens no console, de forma que podemos ver como o nosso programa está se comportando.