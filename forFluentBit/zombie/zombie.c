#include <stdlib.h>
#include <sys/types.h>
#include <unistd.h>
int main ()
{
	pid_t child_pid;child_pid = fork ();
	if (child_pid > 0) {
		sleep(300);
	}
	else {
		exit(0);
	}
	return 0;
}

// ps axo stat,ppid,pid,comm | grep -w defunct
// https://vitux.com/how-to-create-a-dummy-zombie-process-in-ubuntu/

// ps -A -ostat,pid,ppid | grep -e '[zZ]'
// https://itsfoss.com/kill-zombie-process-linux/

// cc -g -o zombie zombie.c
