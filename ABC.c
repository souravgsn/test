#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/stat.h>
#include <stdlib.h>
int main()
{
    int i = 0, ie = 0, io = 0, n, temp;
    printf("Input the value of n: ");
    scanf("%d", &n);

    char bufAllW[n], bufAllR[n], bufOddW[n], bufOddR[n], bufEvenW[n],
        bufEvenR[n];
    for (i = 0; i < n; i++)
    {
        bufAllW[0] = i;
    }

    int fdAll, fdEven, fdOdd;
    fdAll = open("All.txt", O_CREAT | O_WRONLY, S_IRWXU);
    write(fdAll, bufAllW, n);

    read(fdAll, bufAllR, n);

    for (i = 0; i < n; i++)
    {
        temp = bufAllR[i];
        if (temp % 2 == 0)
        {
            bufEvenW[ie] = bufAllR[i];
            ie++;
        }
        else
        {
            bufOddW[io] = bufAllR[i];
            ie++;
        }
    }
    close(fdAll);
    fdEven = open("Even.txt", O_CREAT | O_RDWR, S_IRWXU);
    write(fdEven, bufEvenW, n / 2);
    close(fdEven);

    fdOdd = open("Odd.txt", O_CREAT | O_RDWR, S_IRWXU);
    write(fdOdd, bufOddW, n / 2);
    close(fdOdd);

    return 0;
}
