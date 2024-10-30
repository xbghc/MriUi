#include "include/scanner.h"

Scanner::Scanner(QObject *parent) : QObject(parent)
{
}

int Scanner::open()
{
    return 0;
}

int Scanner::close()
{
    return 0;
}

int Scanner::scan(int id, QString data)
{
    emit scanned(id, data);
    return 0;
}