#include <stdio.h>
#include <sys/statvfs.h>

int main(int argc, char** argv) {
    struct statvfs buf = {0};
    statvfs(argv[1], &buf);
    unsigned long avail = buf.f_bsize * buf.f_bavail;
    unsigned long max = buf.f_bsize * buf.f_blocks;
    double pct = (double)(max - avail) / (double)max * 100.0;
    printf("%s: %6.1fG (%2.0f%%)\n", argv[1], (max - avail) / 1024.0 / 1024.0 / 1024.0, pct);
}
