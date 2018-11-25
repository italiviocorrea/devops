#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void usage() {
  printf("Uso do hadoop-deploy: \n");
  printf("\t hadoop-deploy [-h|--help] [-m <hadoop-host>] [-a <application>] <maven-target-dir>\n");
}

int file_exists(const char *filename) {
  FILE *file;
  if ((file = fopen(filename, "r"))) {
    fclose(file);
    return 1;
  }
  return 0;
}

int main(int argc, char* argv[]) {
  char app[64], manager[64], target[256], cmd[256], id[64], user[64];
  memset(app, '\0', 64);
  memset(manager, '\0', 64);
  strcpy(manager, "s0767.ms");
  memset(cmd, '\0', 256); 
  memset(target, '\0', 256); 
  memset(id, '\0', 64); 
  strcpy(id, "/opt/swarm/private/hd_id_rsa");
  memset(user, '\0', 64); 
  strcpy(user, "sgi");

  if (argc < 3) {
    usage();
    return EXIT_FAILURE;
  }

  for (int i = 1; i < argc; i++) {
    if (strcmp(argv[i], "-h") == 0 || strcmp(argv[i], "--help") == 0) {
      usage();
      return EXIT_SUCCESS;
    }
    if (strcmp(argv[i], "-m") == 0) strcpy(manager, argv[++i]);
    if (strcmp(argv[i], "-a") == 0) strcpy(app, argv[++i]);
    strcpy(target, argv[i]);
  } 

  if (strlen(app) == 0) {
    printf("O nome da aplicacao e obrigatorio. \n");
    usage();
    return EXIT_FAILURE;
  }

  if (strcmp(app, "one-java") == 0) {
    printf("Fazendo o deploy da aplicacao %s utilizando o manager %s... \n", app, manager);
    
    // Atualizando dependencias
    sprintf(cmd, "ssh -i %s %s@%s \"rm -f /home/sgi/one/lib/*\"", id, user, manager); system(cmd);
    sprintf(cmd, "scp -i %s %s/lib/* %s@%s:/home/sgi/one/lib/", id, target, user, manager); system(cmd);

    // Atualiza executavel
    sprintf(cmd, "ls -1 %s | grep one-java > current", target); system(cmd);
    sprintf(cmd, "scp -i %s current %s@%s:/home/sgi/one/", id, user, manager); system(cmd);
    sprintf(cmd, "scp -i %s %s/$(cat current) %s@%s:/home/sgi/one/", id, target, user, manager); system(cmd);

    // Reiniciando servico
    sprintf(cmd, "ssh -i %s %s@%s \"/home/sgi/one/restart < /dev/null > /home/sgi/one/restart.log 2>&1 &\"", id, user, manager); system(cmd); 

    printf("Deploy executado com sucesso...\n");
    return EXIT_SUCCESS;
  }

  printf("A aplicacao %s nao esta configurada para deploy automatico...\n", app);
  return EXIT_FAILURE;
}
