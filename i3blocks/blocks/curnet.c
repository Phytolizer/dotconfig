#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

long read_bytes(const char* path) {
    FILE* fp = fopen(path, "r");
    char linebuf[128];
    fgets(linebuf, sizeof linebuf, fp);
    fclose(fp);
    return strtol(linebuf, NULL, 10);
}

int main(int argc, char** argv) {
    char pathbuf[1024];
    long prev_rx = -1;
    long prev_tx = -1;
    while (true) {
        snprintf(pathbuf, sizeof pathbuf, "/sys/class/net/%s/statistics/tx_bytes", argv[1]);
        long tx = read_bytes(pathbuf);
        snprintf(pathbuf, sizeof pathbuf, "/sys/class/net/%s/statistics/rx_bytes", argv[1]);
        long rx = read_bytes(pathbuf);
        printf("NET %6.1fK / %6.1fK\n", (double)(tx - prev_tx) / 1024.0,
               (double)(rx - prev_rx) / 1024.0);
        fflush(stdout);
        prev_rx = rx;
        prev_tx = tx;
        usleep(1000000);
    }
}
