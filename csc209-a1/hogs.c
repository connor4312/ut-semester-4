#include <stdio.h>
#include <string.h>

typedef int bool;
#define true 1
#define false 0

typedef enum {RAM, CPU} Target;

bool parse_args(int argc, char *argv[], Target *target, char **username) {
    if (argc < 2) {
        return false;
    }

    if (argc == 2) {
        *target = CPU;
        *username = argv[1];
        return true;
    }

    *username = argv[2];
    if (strcmp(argv[1], "-c")) {
        *target = CPU;
    } else {
        *target = RAM;
    }

    return true;
}

typedef struct {
    char *user;
    int pid;
    float cpu;
    float memory;
    char *process;
} Line;

bool extract_line(Line *self) {
    int output;
    int k;

    for (int i = 0; i < 6; i++) {
        switch (i) {
        case 0: output = scanf("%s ", self->user); break;
        case 1: output = scanf("%d ", &self->pid); break;
        case 2: output = scanf("%f ", &self->cpu); break;
        case 3: output = scanf("%f ", &self->memory); break;
        case 4:
            // skip over several columns
            for (k = 0; k < 6; k++) output = scanf("%s", self->process);
        break;
        case 5: output = scanf("%s", self->process); break;
        }

        if (output == EOF) {
            return false;
        }
    }

    return true;
}

float target_stat(Line *self, Target target) {
    if (target == RAM) {
        return self->memory;
    } else {
        return self->cpu;
    }
}

bool extract_max(Target target, char *username, int *max_pid, float *max_stat) {
    bool found = false;
    char *max_name = NULL;
    float stat;
    Line l;

    while (extract_line(&l)) {
        if (!strcmp((&l)->user, username)) {
            continue;
        }

        stat = target_stat(&l, target);
        if (stat > *max_stat || (stat == *max_stat && strcasecmp(max_name, (&l)->process) > 0)) {
            found = true;
            *max_stat = stat;
            strcpy(max_name, (&l)->process);
        }
    }

    return found;
}

int main(int argc, char *argv[])
{
    Target target;
    char *username;
    float max_stat;
    int max_pid;

    if (!parse_args(argc, argv, &target, &username)) {
        printf("Invalid arguments. Usage: hogs [username] [-m|-c]\n");
        return 1;
    }

    if (extract_max(target, username, &max_pid, &max_stat)) {
        printf("%d\t%f.1", max_pid, max_stat);
    }

    return 0;
}
