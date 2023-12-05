#include <iostream>
#include <fstream>
#include <sstream>
#include <list>

std::string filter(const std::string& str)
{
    if(str.substr(0, 5) == "Lemas")
    {
        return "";
    }
    if(str.substr(0, 3) == "num" || str.substr(0, 3) == "Num")
    {
        return "";
    }
    if(str == "ViolentCrimesPerPop")
    {
        return "";
    }
    if(str == "state")
    {
        return "";
    }
    if(str == "county")
    {
        return "";
    }
    if(str == "community")
    {
        return "";
    }
    if(str == "communityname")
    {
        return "";
    }
    if(str == "fold")
    {
        return "";
    }
    if(str == "PolicPerPop")
    {
        return "";
    }
    if(str == "RacialMatchCommPol")
    {
        return "";
    }
    if(str == "PctPolicWhite")
    {
        return "";
    }
    if(str == "PctPolicBlack")
    {
        return "";
    }
    if(str == "PctPolicHisp")
    {
        return "";
    }
    if(str == "PctPolicAsian")
    {
        return "";
    }
    if(str == "PctPolicMinor")
    {
        return "";
    }
    if(str == "OfficAssgnDrugUnits")
    {
        return "";
    }
    if(str == "PolicAveOTWorked")
    {
        return "";
    }
    if(str == "PolicCars")
    {
        return "";
    }
    if(str == "PolicOperBudg")
    {
        return "";
    }
    if(str == "PolicBudgPerPop")
    {
        return "";
    }
    return str + " + ";
}

int main()
{
    std::ifstream in;
    in.open("variables.txt");
    std::string str;
    std::list<std::string> variables;
    while(!in.fail())
    {
        in >> str;
        in >> str;
        if(str.length() == 0)
        {
            break;
        }
        variables.push_back(str.substr(0, str.length()-1));
        std::getline(in, str);
    }

    in.close();

    std::ostringstream oss;
    auto end = variables.end();
    // 120 works
    /*
    for(int i = 0; i < variables.size() - 128; i++)
    {
        end--;
    }
    //*/
    end--;
    std::cout << *end << '\n';
    //end++;
    for(auto it = variables.begin(); it != end; it++)
    {
        oss << filter(*it);
    }
    std::ofstream out;
    out.open("variablesOut.txt");
    out << "full_model <- lm(ViolentCrimesPerPop ~ " << oss.str().substr(0, oss.str().length()-3) << ", data = all_data)\n";
    return 0;
}