# Sobre a imagem
Esta imagem contem a última versão do Alpine Linux 3.10.3, com data e fuso horário atualizados e também com a última versão da OpenJDK 8u232-b09.

# Acesse o container para executar alguns teste

docker run -ti icorrea/openjdk:8u232-jdk-alpine3.10 /bin/sh

# Criar um arquivo com o nome DateTest.java, e cole o conteudo abaixo

import java.util.Date; 
class DateTest {  

    public static void main(String args[]) { 
	Date hoje = new Date();  
	System.out.println(hoje.toString());  
    }
}

# Compilando o programa
javac DateTest.java <ENTER>

# Execute o programa
java -cp . DateTest <ENTER>


