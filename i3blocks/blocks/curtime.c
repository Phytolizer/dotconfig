#include <stdio.h>
#include <sys/time.h>
#include <time.h>

int main(void) {
    time_t now = time(NULL);
    struct tm* now_local = localtime(&now);
    char time_str[128];
    strftime(time_str, sizeof time_str, "%Y-%m-%d %H:%M", now_local);
    printf("%s\n", time_str);
}
