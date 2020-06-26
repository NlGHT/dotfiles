/*
 * Make sure to compile with options -std=c++17 and -lstdc++fs.
 * For example: g++ -std=c++17 -lstdc++fs renameAllHere.cpp -o renameAllHere
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
#include <deque>
namespace fs = std::experimental::filesystem;

struct fileRename {
    std::string originalName;
    std::string newName;
    fileRename(const std::string origName, const std::string inNewName)
        : originalName(origName), newName(inNewName) {}
};


/*
 * DEBUGGING
 */
// void printOrdering(std::deque<std::unique_ptr<fileRename>>& filesToRename) {
    // for (auto& rnObject : filesToRename) {
        // std::cout << "Old name: " << rnObject->originalName << ".  New name: " << rnObject->newName << std::endl;
    // }
// }

// void correctIteratorToName(std::deque<std::unique_ptr<fileRename>>::iterator& it, std::string otherNewName,
        // std::deque<std::unique_ptr<fileRename>>& filesToRename) {
    // it -= 1;
    // if (otherNewName.compare((*it)->newName) != 0) {
        // for (auto it = filesToRename.begin(); it != filesToRename.end(); ++it) {
            // if (otherNewName.compare((*it)->newName) == 0) {
                // break;
            // }
        // }
    // }
// }

// void printDescrepency(std::deque<std::unique_ptr<fileRename>>& filesToRename) {
    // std::vector<std::string> newNames;
    // for (auto& thing : filesToRename) {
        // // std::cout << newNames.size() << std::endl;
        // if (newNames.size() == 0)
            // newNames.push_back(thing->newName);
        // else {
            // for (std::string name : newNames) {
                // if (name.compare(thing->originalName) == 0) {
                    // std::cout << "Descrepency: " << thing->originalName << std::endl;
                    // break;
                // }
            // }

            // newNames.push_back(thing->newName);
        // }
    // }
// }
/*
 * END Debugging
 */


/*
 * START Main Content
 */
bool bitHas(const unsigned int &bitArgs, const unsigned int position) {
    return ((bitArgs & (1 << position)) != 0);
}

void addBit(unsigned int &bitArgs, const unsigned int position) {
    bitArgs |= (1 << position); // sets the 5th-from right
}

void renameFile(const char* origName, const std::string outName, int bitArgs) {
	int result = rename(origName, outName.c_str());
	if (result == 0) {
        if (!bitHas(bitArgs, 1)) {
            // If there is no --silent passed in
            std::cout << "File: " << origName << " renamed to: " << outName << std::endl;
        }
    } else {
		perror("Error renaming file");
    }
}

void renameFile(std::unique_ptr<fileRename>& rnObject, int bitArgs) {
    std::error_code ec;
    if (bitHas(bitArgs, 3)) {
        // Then the --safest option is given
        if (fs::exists(rnObject->newName)) {
            ec.default_error_condition();
            if (!bitHas(bitArgs, 1) && !bitHas(bitArgs, 15))
                std::cout << "File for some reason already existed: " << rnObject->newName << std::endl;
        } else {
            fs::rename(rnObject->originalName, rnObject->newName, ec);
        }
    } else {
        // Just rename without necessarily checking
        fs::rename(rnObject->originalName, rnObject->newName, ec);
    }

    if (!bitHas(bitArgs, 1) && !bitHas(bitArgs, 15)) {
        // If there is no --silent passed in
        std::cout << "File: " << rnObject->originalName << " renamed to: " << rnObject->newName << std::endl;
    }
}

bool addFileAndDeleteIfThere(std::string oldName, std::string newName,
        std::deque<std::unique_ptr<fileRename>>& filesToRename, const unsigned int &bitArgs) {
    bool isCorrected = false;
    int positionLoopSeen = -1;
    int loopCounter = 0;
    for (auto it = filesToRename.begin(); it != filesToRename.end(); it++) {
        if ((*it)->originalName.compare((*it)->newName) == 0) {
            // If the old name of the file is going to be renamed to the new one
            it = filesToRename.erase(it) - 1;
        } else {
            if (oldName.compare((*it)->newName) == 0) {
                if (newName.compare((*it)->originalName) == 0) {
                    // If the edited new name being set is equal to the object's old name, then there is nothing that needs renaming
                    it = filesToRename.erase(it) - 1;
                } else {
                    if (positionLoopSeen > 0) {
                        filesToRename[positionLoopSeen]->originalName.assign((*it)->originalName);
                        it = filesToRename.erase(it) - 1;
                    } else {
                        (*it)->newName.assign(newName);
                        positionLoopSeen = loopCounter;
                    }
                }

                isCorrected = true;
            } else if (newName.compare((*it)->originalName) == 0) {
                if (positionLoopSeen > 0) {
                    filesToRename[positionLoopSeen]->newName.assign((*it)->newName);
                    it = filesToRename.erase(it) - 1;
                } else {
                    (*it)->originalName.assign(oldName);
                    positionLoopSeen = loopCounter;
                }

                isCorrected = true;
            }
        }

        loopCounter++;
    }

    if (isCorrected) {
        return true;
    } else {
        std::unique_ptr<fileRename> fileToBeRenamed(new fileRename(oldName, newName));
        filesToRename.push_back(std::move(fileToBeRenamed));
    }
    return false;
}

int renameInDir(const char* path, const std::string stringInput, unsigned int bitArgs) {
    unsigned int i = 0;
    std::deque<std::unique_ptr<fileRename>> filesToRename;

    if (!bitHas(bitArgs, 1))
        std::cout << "Building and correcting database of files to be renamed..." << std::endl;

    for(fs::directory_entry p: fs::directory_iterator(path)) {
        i++;
        fs::path path = p.path();
        std::string extension = path.extension();
        int extensionLength = extension.length();

        // Build the string for the object being renamed to
        std::string buildName = stringInput;
        buildName += "-";
        buildName += std::to_string(i);
        if (extensionLength > 0) {
            buildName += extension;
        }

        bool result = addFileAndDeleteIfThere(path.filename().string(), buildName, filesToRename, bitArgs);
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

    // std::cout << "Final print out" << std::endl;
    // printOrdering(filesToRename);
    // std::cout << "Descrepencies:" << std::endl;
    // printDescrepency(filesToRename);

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
            } else if (std::strncmp("--safest", argv[i], 8) == 0) {
                addBit(bitArgs, 3);
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
     * --safest : File renaming will check if the file exists first (I can't see a case where it would, but just in case)
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
