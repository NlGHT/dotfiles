#include <iostream>       // std::cout
#include <thread>         // std::this_thread::sleep_until
#include <chrono>         // std::chrono::system_clock
#include <ctime>          // std::time_t, std::tm, std::localtime, std::mktime

int main() 
{
	using std::chrono::system_clock;
	const std::time_t tt = system_clock::to_time_t (system_clock::now());
	struct std::tm * timeStruct = std::localtime(&tt);
	if (timeStruct->tm_hour < 15.0) {
		timeStruct->tm_hour = 15.0;
		timeStruct->tm_min = 30;
		timeStruct->tm_sec = 0;
		std::this_thread::sleep_until (system_clock::from_time_t (mktime(timeStruct)));
	}
	system("/home/night/DownloadedZipApps/iris-mini-0.3.8.AppImage &");
	return 0;
}