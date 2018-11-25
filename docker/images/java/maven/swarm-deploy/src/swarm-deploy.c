#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void usage() {
  printf("Uso do swarm-deploy: \n");
  printf("\t swarm-deploy [-h|--help] [-m <manager-host>] [-i <id-rsa-path>] [-u <user>] <app-name> <yaml>\n");
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
  char app[64], manager[64], yml[128], cmd[256], id[64], user[64];
  memset(app, '\0', 64);
  memset(manager, '\0', 64);
  strcpy(manager, "s1372.ms");
  memset(yml, '\0', 128);
  memset(cmd, '\0', 256); 
  memset(id, '\0', 64); 
  strcpy(id, "/opt/swarm/private/dp_id_rsa");
  memset(user, '\0', 64); 
  strcpy(user, "docker-deployer");

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
    if (strcmp(argv[i], "-i") == 0) strcpy(id, argv[++i]);
    if (strcmp(argv[i], "-u") == 0) strcpy(user, argv[++i]);
    if (i == argc - 2) strcpy(app, argv[i]);
    if (i == argc - 1) strcpy(yml, argv[i]);
  } 

  if (!file_exists(yml)) {
    printf("O arquivo %s nao foi encontrado... \n", yml);
    usage();
    return EXIT_FAILURE;
  }

  if (strlen(app) == 0) {
    printf("O nome da aplicacao e obrigatorio. \n");
    usage();
    return EXIT_FAILURE;
  }

  printf("Fazendo o deploy da aplicacao %s utilizando o manager %s e o arquivo yml %s ... \n", app, manager, yml);
  sprintf(cmd, "ssh -i %s %s@%s \"mkdir -p ~/yml\"", id, user, manager); system(cmd);
  sprintf(cmd, "scp -i %s %s %s@%s:~/yml", id, yml, user, manager); system(cmd);
  sprintf(cmd, "ssh -i %s %s@%s \"docker stack deploy -c ~/yml/%s %s --with-registry-auth\"", id, user, manager, yml, app); system(cmd);
  sprintf(cmd, "ssh -i %s %s@%s \"rm -f ~/yml/%s\"", id, user, manager, yml); system(cmd);
  return EXIT_SUCCESS;
}
