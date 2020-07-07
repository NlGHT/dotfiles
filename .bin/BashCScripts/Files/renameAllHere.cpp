/*
 * Make sure to compile with options -std=c++17 and -lstdc++fs.
 * For example: g++ renameAllHere.cpp -std=c++17 -o renameAllHere -lstdc++fs
 * Or for debugging with gdb: g++ -g -std=c++17 -lstdc++fs renameAllHere.cpp -o renameAllHere
 *
 */

#include <stdio.h>
#include <iostream>
#include <cstring>
#include <string>
#include <experimental/filesystem>
#include <system_error>
#include <vector>
namespace fs = std::experimental::filesystem;

struct fileRename {
    std::string originalName;
    std::string newName;
    fileRename(const std::string origName, const std::string inNewName)
        : originalName(origName), newName(inNewName) {}
};

bool bitHas(const unsigned int &bitArgs, const unsigned int position) {
    return ((bitArgs & (1 << position)) != 0);
}

void addBit(unsigned int &bitArgs, const unsigned int position) {
    bitArgs |= (1 << position);
}

void renameFile(std::unique_ptr<fileRename>& rnObject, int bitArgs) {
    std::error_code ec;
    if (fs::exists(rnObject->newName)) {
        ec.default_error_condition();
        if (!bitHas(bitArgs, 1) && !bitHas(bitArgs, 15))
            // If there is no --silent passed in or the rename count is over 500
            std::cout << "File: " << rnObject->newName << " already exists, skipping..." << std::endl;
    } else {
        fs::rename(rnObject->originalName, rnObject->newName, ec);
        if (!bitHas(bitArgs, 1) && !bitHas(bitArgs, 15))
            // If there is no --silent passed in or the rename count is over 500
            std::cout << "File: " << rnObject->originalName << " renamed to: " << rnObject->newName << std::endl;
    }
}

void addFileRename(std::string oldName, std::string newName, std::vector<std::unique_ptr<fileRename>>& filesToRename) {
    std::unique_ptr<fileRename> fileToBeRenamed(new fileRename(oldName, newName));
    filesToRename.push_back(std::move(fileToBeRenamed));
}

int renameInDir(const char* path, const std::string stringInput, unsigned int bitArgs) {
    unsigned int i = 0;
    std::vector<std::unique_ptr<fileRename>> filesToRename;

    if (!bitHas(bitArgs, 1))
        std::cout << "Building and correcting database of files to be renamed..." << std::endl;

    for(fs::directory_entry p: fs::directory_iterator(path)) {
        i++;
        fs::path path = p.path();
        std::string extension = path.extension();

        // Build the string for the object being renamed to
        std::string buildName = stringInput;
        buildName += "-";
        buildName += std::to_string(i);
        if (path.has_extension()) {
            buildName += extension;
        }

        addFileRename(path.filename().string(), buildName, filesToRename);
    }

    if (!bitHas(bitArgs, 1)) {
        std::cout << "File count: " << i << std::endl;
        std::cout << "Renaming files... Length: " << filesToRename.size() << std::endl;

        // If the count is higher than 500 then don't show all the rename messages,
        // so pass it the equivalent of the --silent option
        if (i > 500)
            addBit(bitArgs, 15);
    }

    for (auto& rnObject : filesToRename) {
        renameFile(rnObject, bitArgs);
    }

    if (!bitHas(bitArgs, 1)) {
        std::cout << "Successfully renamed " << filesToRename.size() << " files." << std::endl;
    }

    return 0;
}

int createName(const unsigned int argStartPosition, int* argc, char* argv[], unsigned int bitArgs) {
    if (*argc > 2) {
        std::string inputString;
        inputString += argv[argStartPosition];

        for (int i = argStartPosition + 1; i < *argc; i++)
            inputString.append(" ").append(argv[i]);
        int renameRetVal = renameInDir(".", inputString, bitArgs);
        if (renameRetVal == -1) {
            if (!bitHas(bitArgs, 1))
                std::cout << "Directory not found." << std::endl;
            return 1;
        }
    } else {
        int renameRetVal = renameInDir(".", argv[argStartPosition], bitArgs);
        if (renameRetVal == -1) {
            if (!bitHas(bitArgs, 1))
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
                addBit(bitArgs, 1);
            }

            countOptionArgs++;
        } else {
            break;
        }
    }

    if (*argCount > 0 && countOptionArgs == *argCount - 1) {
        // Then there is no text as argument
        addBit(bitArgs, 10);
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
        if (bitHas(bitArgs, 10)) {
            if (!bitHas(bitArgs, 1))
                std::cout << "Only options given" << std::endl;
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
