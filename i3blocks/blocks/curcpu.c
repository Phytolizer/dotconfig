#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

typedef struct {
    size_t idle;
    size_t non_idle;
} cpu_instant_t;

cpu_instant_t snapshot(void) {
    FILE* fp = fopen("/proc/stat", "r");
    char line_buffer[1024] = {0};
    fgets(line_buffer, sizeof line_buffer, fp);
    fclose(fp);

    char* begin = strstr(line_buffer, "cpu") + 3;
    char* next;
    cpu_instant_t result = {0};
    size_t i = 0;
    long num;
    while ((num = strtol(begin, &next, 10)) != 0) {
        begin = next;
        if (i == 3 || i == 4) {
            result.idle += num;
        } else {
            result.non_idle += num;
        }
        i += 1;
    }
    return result;
}

int main(void) {
    cpu_instant_t begin = snapshot();

    printf("CPU ??%%\n");
    fflush(stdout);

    while (true) {
        sleep(1);
        cpu_instant_t end = snapshot();

        double delta_idle = (double)end.idle - (double)begin.idle;
        double delta_non_idle = (double)end.non_idle - (double)begin.non_idle;

        printf("CPU %2.0f%%\n", (delta_non_idle / (delta_non_idle + delta_idle)) * 100.0);
        fflush(stdout);
        begin = end;
    }
}
