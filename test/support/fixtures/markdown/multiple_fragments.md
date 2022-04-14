# Com a anotação @Configuration podemos criar classes para configuração de beans   

 O Spring consegue fazer a injeção de dependências praticamente sozinho, mas chegou a hora de aprender a fazer algumas personalizações para resolver situações como:

 - Transformar uma classe que não seja uma *@Service, @Controller ou @Repository* em um bean gerenciado pelo Spring também;

 - Resolver casos de ambiguidade de beans com as annotations *@Qualifier e @Primary*.

Vamos recapitular como fazer a configuração de beans via classe @Configuration: 🤔

````java
 @Configuration
 public class CloudConfig {

     @Bean
     public  CloudInformation AWSConfig(String user, String password) {
         return new CloudInformation()
     }

     @Bean
     public  CloudInformation AzureConfig(String user, String password) {
         return new CloudInformation()
     }
 }

````

Olhando para o código anterior, aparentemente tudo está certo, né? Mas quando alguma classe fosse usar um bean do tipo *CloudInformation*, qual deles seria utilizado? Vamos conferir a resposta dessa pergunta a seguir:

````java
 @Service
 public class ConnectToCloudDatabaseService {

     @Autowired
     private CloudConfig  cloudConfig;
 }

````
No momento da escrita do código acima, não seria apresentado nenhum erro; porém, ao executar a aplicação, teríamos um erro de *NoUniqueBeanDefinitionException*, pois o IOC container não ia saber se desejamos implementar o da AWS ou da Azure, visto que os dois são do mesmo tipo.

O Spring nos fornece duas opções para fazer essa diferenciação: @primary e @Qualiifer. Confira o que essas anotações significam abaixo 👇

- *@Primary* 
Informa para o Spring para qual dos Beans de um mesmo tipo ele deve dar preferência quando o container IOC for iniciado.

Para fazer essa diferenciação, basta fazer esse ajuste na classe de Config:

````java
 @Configuration
 public class CloudConfig {

     @Primary
     @Bean
     public  CloudInformation AWSConfig(String user, String password) {
         return new CloudInformation()
     }

     @Bean
     public  CloudInformation AzureConfig(String user, String password) {
         return new CloudInformation()
     }
 }

````
- *@Qualifier* 

Para usar essa annotation, podemos fazer a configuração direto na classe que vai utilizar esse bean, informando qual dos dois beans daquele determinado tipo aquela classe deseja utilizar.


````java
 @Service
 public class ConnectToCloudDatabaseService {

    @Qualifier("AzureConfig")
     @Autowired
     private CloudConfig  cloudConfig;
 }

````

A diferença do *@Qualifier* para o *@Primary* é que o primeiro deve especificar em cada caso qual dos dois beans deseja usar, e o segundo sempre deixa fixo qual será utilizado.

Se no mesmo projeto temos uma configuração do tipo *@Primary* e *@Qualifier*, o qualifier terá precedência e vai sobrescrever a Primary.