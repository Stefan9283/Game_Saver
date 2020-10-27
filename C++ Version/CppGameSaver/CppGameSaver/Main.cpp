using namespace std;
#include <iostream>
#include <fstream>
#include <string>
#include <stdlib.h>


struct Properties
{
	string name;
	string path;
};

Properties BreakIntoTokens(string game)
{
	char* pch;


	char* string = (char*)calloc(game.size() + 1, sizeof(char));

	strcpy(string, game.data());

	pch = strtok(string, "%");

	Properties props;

	printf("%s\n", pch);
	if (!pch) throw std::runtime_error("Name is null\n");
	props.name = pch;
	pch = strtok(NULL, "%");

	printf("%s\n\n", pch);
	if (!pch) throw std::runtime_error("Path is null\n");
	props.path = pch;

	

	free(string);

	return props;
}

void doSomeSaving(string game)
{
	Properties props = BreakIntoTokens(game);


}




int main()
{
	ifstream myfile;
	myfile.open("example.txt");
	if (!myfile.is_open())
		throw std::runtime_error("File cannot be opened\n");
	string line;
	while (getline(myfile, line))
	{
		//cout << "str " << line << '\n';
		doSomeSaving(line);
	}
	myfile.close();
	return 0;
}