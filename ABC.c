#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int main() {
    int n;
    printf("Enter a number: ");
    scanf("%d", &n);

    // Open the files for writing
    int evenFd = open("even.txt", O_CREAT | O_TRUNC | O_WRONLY, 0644);
    int oddFd = open("odd.txt", O_CREAT | O_TRUNC | O_WRONLY, 0644);

    // Check if the files were successfully opened
    if (evenFd < 0 || oddFd < 0) {
        printf("Error opening files\n");
        exit(1);
    }

    // Write the even and odd numbers to their respective files
    for (int i = 1; i <= n; i++) {
        if (i % 2 == 0) {
            char buffer[20];
            int len = sprintf(buffer, "%d\n", i);
            write(evenFd, buffer, len);
        } else {
            char buffer[20];
            int len = sprintf(buffer, "%d\n", i);
            write(oddFd, buffer, len);
        }
    }

    // Close the files
    close(evenFd);
    close(oddFd);

    return 0;
}
