#include <QString>
#include <QtTest>
#include <QCoreApplication>

class FoundationTest : public QObject
{
    Q_OBJECT

public:
    FoundationTest();

private Q_SLOTS:
    void initTestCase();
    void cleanupTestCase();
    void testQString();
    void testNumbers();
    void testStringArg();
    void testUnicode();
    void testContainer();
    void testDictionary();
    void testFileIO();
};

FoundationTest::FoundationTest()
{
}

void FoundationTest::initTestCase()
{
}

void FoundationTest::cleanupTestCase()
{
}

void FoundationTest::testQString()
{
    // M1>>
    QString data("A,B,C,D"); // create a simple string
    // split it into parts
    QStringList list = data.split(",");
    // create a new string out of the parts
    QString out = list.join(",");
    // verify both are the same
    QVERIFY(data == out);
    // change the first character to upper case
    QVERIFY(QString("A") == out[0].toUpper());
    // M1<<
}

void FoundationTest::testNumbers()
{
    // M2>>
    // create some variables
    int v = 10;
    int base = 10;
    // convert an int to a string
    QString a = QString::number(v, base);
    // and back using and sets ok to true on success
    bool ok(false);
    int v2 = a.toInt(&ok, base);
    // verify our results
    QVERIFY(ok == true);
    QVERIFY(v = v2);
    // M2<<
}

void FoundationTest::testStringArg()
{
    // M3>>
    // create a name
    QString name("Joe");
    // get the day of the week as string
    QString weekday = QDate::currentDate().toString("dddd");
    // format a text using paramters (%1, %2)
    QString hello = QString("Hello %1. Today is %2.").arg(name).arg(weekday);
    // This worked on Monday. Promise!
    if(Qt::Monday == QDate::currentDate().dayOfWeek()) {
        QCOMPARE(QString("Hello Joe. Today is Monday."), hello);
    } else {
        QVERIFY(QString("Hello Joe. Today is Monday.") !=  hello);
    }
    // M3<<
}


void FoundationTest::testUnicode()
{
    // M4>>
    // Create a unicode character using the unicode for smile :-)
    QChar smile(0x263A);
    // you should see a :-) on you console
    qDebug() << smile;
    // Use a unicode in a string
    QChar smile2 = QString("\u263A").at(0);
    QVERIFY(smile == smile2);
    // Create 12 smiles in a vector
    QVector<QChar> smilies(12);
    smilies.fill(smile);
    // Can you see the smiles
    qDebug() << smilies;
    // M4<<
}

void FoundationTest::testContainer()
{
    // M5>>
    // Create a simple list of ints using the new C++11 initialization
    // for this you need to add "CONFIG += c++11" to your pro file.
    QList<int> list{1,2};

    // append another int
    list << 3;

    // We are using scopes to avoid variable name clashes

    { // iterate through list using Qt for each
        int sum(0);
        foreach (int v, list) {
            sum += v;
        }
        QVERIFY(sum == 6);
    }
    { // iterate through list using C++ 11 range based loop
        int sum = 0;
        for(int v : list) {
            sum+= v;
        }
        QVERIFY(sum == 6);
    }

    { // iterate through list using JAVA style iterators
        int sum = 0;
        QListIterator<int> i(list);

        while (i.hasNext()) {
            sum += i.next();
        }
        QVERIFY(sum == 6);
    }

    { // iterate through list using STL style iterator
        int sum = 0;
        QList<int>::iterator i;
        for (i = list.begin(); i != list.end(); ++i) {
            sum += *i;
        }
        QVERIFY(sum == 6);
    }


    // using std::sort with mutable iterator using C++11
    // list will be sorted in descending order
    std::sort(list.begin(), list.end(), [](int a, int b) { return a > b; });
    QVERIFY(list == QList<int>({3,2,1}));


    int value = 3;
    { // using std::find with const iterator
        QList<int>::const_iterator result = std::find(list.constBegin(), list.constEnd(), value);
        QVERIFY(*result == value);
    }

    { // using std::find using C++ lambda and C++ 11 auto variable
        auto result = std::find_if(list.constBegin(), list.constBegin(), [value](int v) { return v == value; });
        QVERIFY(*result == value);
    }
    // M5<<
}


void FoundationTest::testDictionary()
{
    // M6>>
    QHash<QString, int> hash({{"b",2},{"c",3},{"a",1}});
    qDebug() << hash.keys(); // a,b,c - unordered
    qDebug() << hash.values(); // 1,2,3 - unordered but same as order as keys

    QVERIFY(hash["a"] == 1);
    QVERIFY(hash.value("a") == 1);
    QVERIFY(hash.contains("c") == true);

    { // JAVA iterator
        int sum =0;
        QHashIterator<QString, int> i(hash);
        while (i.hasNext()) {
            i.next();
            sum+= i.value();
            qDebug() << i.key() << " = " << i.value();
        }
        QVERIFY(sum == 6);
    }

    { // STL iterator
        int sum = 0;
        QHash<QString, int>::const_iterator i = hash.constBegin();
        while (i != hash.constEnd()) {
            sum += i.value();
            qDebug() << i.key() << " = " << i.value();
            i++;
        }
        QVERIFY(sum == 6);
    }

    hash.insert("d", 4);
    QVERIFY(hash.contains("d") == true);
    hash.remove("d");
    QVERIFY(hash.contains("d") == false);

    { // hash find not successfull
        QHash<QString, int>::const_iterator i = hash.find("e");
        QVERIFY(i == hash.end());
    }

    { // hash find successfull
        QHash<QString, int>::const_iterator i = hash.find("c");
        while (i != hash.end()) {
            qDebug() << i.value() << " = " << i.key();
            i++;
        }
    }

    // QMap
    QMap<QString, int> map({{"b",2},{"c",2},{"a",1}});
    qDebug() << map.keys(); // a,b,c - ordered ascending

    QVERIFY(map["a"] == 1);
    QVERIFY(map.value("a") == 1);
    QVERIFY(map.contains("c") == true);

    // JAVA and STL iterator work same as QHash
    // M6<<
}

void FoundationTest::testFileIO()
{
    // M7>>
    QStringList data({"a", "b", "c"});
    { // write binary files
        QFile file("out.bin");
        if(file.open(QIODevice::WriteOnly)) {
            QDataStream stream(&file);
            stream << data;
        }
    }
    { // read binary file
        QFile file("out.bin");
        if(file.open(QIODevice::ReadOnly)) {
            QDataStream stream(&file);
            QStringList data2;
            stream >> data2;
            QCOMPARE(data, data2);
        }
    }
    { // write text file
        QFile file("out.txt");
        if(file.open(QIODevice::WriteOnly)) {
            QTextStream stream(&file);
            QString sdata = data.join(",");
            stream << sdata;
        }
    }
    { // read text file
        QFile file("out.txt");
        if(file.open(QIODevice::ReadOnly)) {
            QTextStream stream(&file);
            QStringList data2;
            QString sdata;
            stream >> sdata;
            data2 = sdata.split(",");
            QCOMPARE(data, data2);
        }
    }
    // M7<<
}

QTEST_MAIN(FoundationTest)

#include "tst_foundation.moc"
