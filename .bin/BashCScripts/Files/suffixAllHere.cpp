#include <stdio.h>
#include <iostream>
#include <dirent.h>
#include <cstring>
#include <string>

void renameFile(char* origName, const std::string outName, int bitArgs) {
	int result = rename(origName, outName.c_str());
	if (result == 0) {
        if ((bitArgs & 1) == 0) {
            // If there is no --silent passed in
            std::cout << "File: " << origName << " renamed to: " << outName << std::endl;
        }
    } else {
		perror("Error renaming file");
    }
}

int renameInDir(const char* path, const std::string stringInput, int bitArgs) {
    struct dirent *entry;
    DIR *dp;

    dp = opendir(path);
    if (dp == NULL) {
        return -1;
    }

    while ((entry = readdir(dp))) {
        if (std::strncmp(entry->d_name, ".", 1) && std::strncmp(entry->d_name, "..", 2)) {
        	signed int periodPosition = 0;
        	char* fileExtension;
        	bool hasPeriod = false;
        	for (int i = strlen(entry->d_name); i > 0; i--) {
        		if (!std::strncmp(entry->d_name+i, ".", 1)) {
        			periodPosition = i;
        			fileExtension = entry->d_name+i;
        			hasPeriod = true;
        			break;
        		}
        	}

	        if (hasPeriod) {
	        	std::string outName;
	        	outName += entry->d_name;
	        	outName = outName.erase(periodPosition, strlen(outName.c_str())-periodPosition);
	        	outName += stringInput;
	        	outName += fileExtension;
	        	renameFile(entry->d_name, outName, bitArgs);
	        } else {
	        	std::string outName;
	        	outName += entry->d_name;
	        	outName += stringInput;
	        	renameFile(entry->d_name, outName, bitArgs);
	        }
	    }
    }

    closedir(dp);
    return 0;
}

int createName(const unsigned int argStartPosition, int* argc, char* argv[], const unsigned int bitArgs) {
    if (*argc > 2) {
        std::string inputString;
        inputString += argv[argStartPosition];

        for (int i = argStartPosition + 1; i < *argc; i++)
            inputString.append(" ").append(argv[i]);
        int renameRetVal = renameInDir(".", inputString, bitArgs);
        if (renameRetVal == -1) {
            if ((bitArgs & 1) == 0)
                std::cout << "Directory not found." << std::endl;
            return 1;
        }
    } else {
        int renameRetVal = renameInDir(".", argv[argStartPosition], bitArgs);
        if (renameRetVal == -1) {
            if ((bitArgs & 1) == 0)
                std::cout << "Directory not found." << std::endl;
            return 1;
        }
    }
    return 0;
}

unsigned int checkArgs(int* argCount, char* argv[]) {
    // 1 = silent
    unsigned int bitArgs = 0;
    unsigned int countOptionArgs = 0;
    for (int i = 1; i < *argCount; i -= -1) {
        if (std::strncmp("--", argv[i], 2) == 0) {
            // If there is an option arg
            if (std::strncmp("--silent", argv[i], 8) == 0) {
                // Then silent arg is active
                if ((bitArgs & 1) == 0) {
                    // Only add value to bit if not there
                    bitArgs += 1;
                }
            }

            countOptionArgs++;
        } else {
            break;
        }
    }

    if (countOptionArgs == *argCount - 1) {
        // Then there is no text as argument
        bitArgs += 0x2 ^ 10;
    }

    return bitArgs;
}

int main(int argc, char* argv[]) {
    /*
     * OPTIONS:
     * --silent : No printing of files renamed.
     *
     */

	if (argc == 1) {
		std::cout << "No parameter specified." << std::endl;
	} else {
        int bitArgs = checkArgs(&argc, argv);
        if ((bitArgs & (0x2^10)) > 0) {
            if ((bitArgs & 1) == 0)
                std::cout << "Only options given." << std::endl;
            return 1;
        }

        unsigned int firstNonArg = 1;
        if (bitArgs != 0) {
            for (int i = 1; i < argc; i++) {
                if (std::strncmp("--", argv[i], 2) != 0) {
                    firstNonArg = i;
                    break;
                }
            }
        }

        createName(firstNonArg, &argc, argv, bitArgs);
	}

	return 0;
}
