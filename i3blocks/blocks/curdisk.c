#include <stdio.h>
#include <sys/statvfs.h>

int main(void) {
    struct statvfs buf = {0};
    statvfs("/", &buf);
    unsigned long avail = buf.f_bsize * buf.f_bavail;
    unsigned long max = buf.f_bsize * buf.f_blocks;
    double pct = (double)(max - avail) / (double)max * 100.0;
    printf("DSK %5.1fG (%2.0f%%)\n", (max - avail) / 1024.0 / 1024.0 / 1024.0, pct);
}
