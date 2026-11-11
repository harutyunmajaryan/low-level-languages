#include <iostream>
#include <string>
#include <vector>
#include <cstddef>

using namespace std;


class BankAccount {
private:
    string name;
    string lastName;
    string accountNumber;
    int balance;

public:
    BankAccount(string name, string lastName, string accountNumber, int balance){
        this->name = name;
        this->lastName = lastName;
        this->accountNumber = accountNumber;
        this->balance = balance;
    }

    string getName() const {
        return name;
    }
    string getLastName() const {
        return lastName;
    }
    string getaccountNumber() const {
        return accountNumber;
    }
    int getBalance() const {
        return balance;
    }
};



int main(int argc, char* argv[]){

    vector<BankAccount> accounts = {
        BankAccount{"Harutyun", "Majaryan", "14502938", 1000},
        BankAccount{"Mark", "Ghalumyan", "13423124", 400},
        BankAccount{"Antony", "Jane", "12419900", 124},
        BankAccount{"Sara", "Alchemi", "89801333", 2411}
    };

    if (argc != 5){
        return -1;   
    }

    string param1 = argv[1];
    string param2 = argv[2];
    string param3 = argv[3];
    int param4 = std::stoi(argv[4]);

    for (const BankAccount& account : accounts){
        if ((account.getName() == param1) && 
            (account.getLastName() == param2) && 
            (account.getaccountNumber() == param3) && 
            (account.getBalance() == param4)){
            
            cout << "Found matching account!" << endl;
        }else{
            cout << "The account does not exist"<<endl;
            break;
        }
    }

    return 0;
}
