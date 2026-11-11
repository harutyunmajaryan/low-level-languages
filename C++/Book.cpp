#include <iostream>
#include <string>
#include <vector>
#include <cstddef>
using namespace std;


class Book{
private:
   string bookName;
   string authorName;
   int publishedDate;

public:
   Book(string bookName, string authorName, int publishedDate){
    this->bookName = bookName;
    this->authorName = authorName;
    this->publishedDate = publishedDate;
   }

   string getbookName() const{
    return bookName;
   }

   string getauthorName() const {
    return authorName;
   }

   int getpublishedDate() const {
    return publishedDate;
   }
};

void Available(const vector<Book>& library, const string& bName, const string& aName, int date){
    bool found = false;
    vector<Book> foundBook{};
    for(Book book : library){
        if (book.getbookName() == bName && book.getauthorName() == aName && book.getpublishedDate() == date){
            std::cout<<"The book exists in our library!"<<endl;
            found = true;
            break;
        }
    }

    if (!found){
        std::cout<<"Book not found in the library"<<endl;
    }
}

int main(int argc, char* argv[]){
    if (argc != 4){
        return -1;
    }

    vector<Book> library = {
        Book{"The Hobbit", "J.R.R Tolkien", 1937},
        Book{"The Great Gatsby", "F.Scott Fitzgerald", 1925},
        Book{"Dune", "Frank Herbert", 1965},
        Book{"The Catcher in the Rye", "J.D Salinger", 1951},
        Book{"Harry Potter", "J.K Rowling", 1997}
    };

    //get the elements from terminal 
    string bName = argv[1];
    string aName = argv[2];
    int date = std::stoi(argv[3]);

    Available(library, bName, aName, date);  
    return 0;
}
