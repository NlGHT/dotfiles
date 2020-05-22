#include <stdio.h>
#include <iostream>
#include <dirent.h>
#include <cstring>
#include <string>

void renameFile(char* origName, const std::string outName) {
	int result = rename(origName, outName.c_str());
	if (result == 0)
		std::cout << "File: " << origName << " renamed to: " << outName << std::endl;
	else
		perror("Error renaming file");
}

int renameInDir(const char* path, const std::string stringInput) {
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
                    // std::cout << "i is: " << i << std::endl;
        			break;
        		}
        	}

	        if (hasPeriod) {
	        	std::string outName;
	        	outName += entry->d_name;
	        	outName = outName.erase(periodPosition, strlen(outName.c_str())-periodPosition);
	        	outName += stringInput;
	        	outName += fileExtension;
	        	renameFile(entry->d_name, outName);
	        } else {
	        	std::string outName;
	        	outName += entry->d_name;
	        	outName += stringInput;
	        	renameFile(entry->d_name, outName);
	        }
	    }
    }

    closedir(dp);
    return 0;
}

int main(int argc, char* argv[]) {
	if (argc == 1) {
		std::cout << "No parameter specified." << std::endl;
	} else {
		if (argc > 2) {
			std::string inputString;
			inputString += argv[1];
			for (int i = 2; i < argc; i++)
				inputString.append(" ").append(argv[i]);
			int renameRetVal = renameInDir(".", inputString);
			if (renameRetVal == -1)
				std::cout << "Directory not found." << std::endl;
		} else {
			int renameRetVal = renameInDir(".", argv[1]);
			if (renameRetVal == -1)
				std::cout << "Directory not found." << std::endl;
		}
	}
	return 0;
}
