#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define FILENAME "input.txt"

unsigned long long* loadinput() {
    unsigned long long* lanternfish = (unsigned long long*)malloc(sizeof(unsigned long long) * 9);
    FILE* input = fopen(FILENAME, "r");

    char* line = NULL;
    size_t len = 0;
    while (getline(&line, &len, input) != -1) {
        char* value = strtok(line, ",");
        while (value != NULL) {
            int age = atoi(value);
            lanternfish[age]++;
            value = strtok(NULL, ",");
        }
    }

    free(line);
    fclose(input);

    return lanternfish;
}

void startsim(unsigned long long* lanternfish, int days) {
    int day = 0;
    while (day < days) {
        unsigned long long newfishes = lanternfish[0];
        int i;

        for (i = 0; i < 8; i++) {
            lanternfish[i] = lanternfish[i + 1];
        }

        lanternfish[6] += newfishes;
        lanternfish[8] = newfishes;

        day++;
    }
}

int main(int argc, char* argv[]) {
    if (argc != 2) {
        fprintf(stderr, "part-one <days>\n");
        exit(EXIT_FAILURE);
    }

    int days = atoi(argv[1]);

    unsigned long long* lanternfish = loadinput();
    startsim(lanternfish, days);

    int i;
    unsigned long long total = 0;
    for (i = 0; i < 9; i++) {
        printf("Lanternfish with age %i: %llu\n", i, lanternfish[i]);
        total += lanternfish[i];
    }

    printf("Total: %llu\n", total);

    free(lanternfish);

    return 0;
}
