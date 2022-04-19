#include <stdio.h>
#include <string.h>

int main(void) {
    FILE* fp = fopen("/proc/meminfo", "r");
    char line_buf[1024] = {0};
    long mem_total;
    long mem_available;
    while (fgets(line_buf, sizeof line_buf, fp) != NULL) {
        sscanf(line_buf, "MemTotal: %ld kB", &mem_total);
        sscanf(line_buf, "MemAvailable: %ld kB", &mem_available);
    }

    long mem_used = mem_total - mem_available;
    printf("MEM %4.1fG\n", mem_used / 1024.0 / 1024.0);
}
