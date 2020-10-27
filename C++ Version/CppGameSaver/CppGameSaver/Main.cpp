#include <iostream>
#include <fstream>
#include <string>
#include <stdlib.h>

#include <filesystem>

#define SAVES "SAVES"

struct Properties
{
	std::string name;
	std::string path;
};

Properties BreakIntoTokens(std::string game, const char* delim)
{
	char* pch;

	char* string = (char*)calloc(game.size() + 1, sizeof(char));

	strcpy(string, game.data());

	pch = strtok(string, delim);

	Properties props;

	//printf("%s\n", pch);
	if (!pch) throw std::runtime_error("Name is null\n");
	props.name = pch;
	pch = strtok(NULL, delim);

	//printf("%s\n\n", pch);
	if (!pch) throw std::runtime_error("Path is null\n");
	props.path = pch;

	

	free(string);

	return props;
}

void doSomeSaving(std::string game)
{
	Properties props = BreakIntoTokens(game, "%");
	std::cout << props.name.c_str() ;
	

	std::string savedir = SAVES;
	savedir.append("/");
	savedir.append(props.name);

	std::filesystem::create_directory(savedir.c_str());

	if (std::filesystem::is_directory(props.path.c_str()))
		std::filesystem::copy(props.path.c_str(), savedir.c_str(), 
			  std::filesystem::copy_options::update_existing | std::filesystem::copy_options::recursive
			
		);
	else std::cout << " NO SAVE";

	std::cout <<  "\n";
}



int main()
{
	std::ifstream myfile;
	myfile.open("example.txt");
	if (!myfile.is_open())
		throw std::runtime_error("File cannot be opened\n");

	std::string line;

	std::filesystem::create_directory(SAVES);

	while (getline(myfile, line))
	{
		doSomeSaving(line);
	}
	myfile.close();


	return 0;
}