# YugabyteDB

É um banco de dados relacional SQL distribuído, de alto desempenho,
 de código aberto e nativo da nuvem para suportar aplicativos globais em escala de Internet.
Permite criar aplicativos em nuvem velozes, atendendo consultas diretamente do banco de dados.
Alcance milhões de transações por segundo e armazene vários TBs de dados por nó.
Implante em regiões e nuvens com replicação síncrona ou multimestre.

**Para executar um container docker basta digitar :**

	docker run -d --name yugabyte  -p 7000:7000 -p 9000:9000 -p 5433:5433 -p 9042:9042 -v ~/svr/yb_data:/home/yugabyte/var icorrea/yugabytedb:latest bin/yugabyted start --daemon=false --ui=false
