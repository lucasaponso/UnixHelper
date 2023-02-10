/* Brightness.c
Modify the brightness on laptop running a linux distro. You need root privileges to run as it read/writes to /sys/class/backlight/intel_backlight/brightness. 
To avoid the password prompt for something as trivial as this, the setuid permission bit wouldn't hurt.
Chown root:user and chmod 4750 suggested
*/

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>

#define BUFSIZE 5
static char *brightness_path = "/sys/class/backlight/intel_backlight/brightness";

int main(int argc, char **argv)
{
	FILE *file = 0;
	char buf[BUFSIZE];
	memset(buf, 0, BUFSIZE);

	if (argc == 1) {
		printf("Enter a predefined brightness value (0-10): ");
		fgets(buf, BUFSIZE, stdin);
		int len = strlen(buf);
		if (len == 1) { /*will have newline, so */
			file = fopen(brightness_path, "r");
			if (!file) {
				fprintf(stderr, "Error opening file to read\n");
				return 1;
			}
			fgets(buf, BUFSIZE, file);
			fclose(file);
			char brightness[3] = "10";
			if (strcmp(buf, "4882") == 0)
				brightness[1] = '\0';
			execlp(argv[0], argv[0], brightness, (char *) 0);
		} else { /*brightness value entered*/
			buf[len-1] = '\0';
			execlp(argv[0], argv[0], buf, (char *)0);
		}
	} else { /*argument given*/
		char *endptr;
		int bval = (int) strtol(argv[1], &endptr, 10);
		if (*endptr != '\0') {
			fprintf(stderr, "Error: Invalid input\n");
			return 1;
		}

		int brightness = 0;
		switch(bval) {
			case -1: brightness = 80;
							 break;
			case 0: brightness = 120;
							break;
			case 10: brightness = 4882;
							 break;
			default: brightness = bval * 500;
		}

		if (brightness > 4882 || brightness < 80) {
			fprintf(stderr, "Error: Invalid input\n");
			return 1;
		}

		file = fopen(brightness_path, "w");
		if (!file) {
			fprintf(stderr, "Error opening file for write\n");
			return 1;
		}
		fprintf(file, "%d", brightness);
		fclose(file);
	}
	
	return 0;
}