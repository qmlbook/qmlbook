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
    QString data("A,B,C,D");
    QStringList list = data.split(",");
    QString out = list.join(",");
    QVERIFY(data == out);
    QVERIFY(QString("A") == out[0].toUpper());
}

void FoundationTest::testNumbers()
{
    int v = 10;
    int base = 10;
    QString a = QString::number(v, base);
    bool ok(false);
    int v2 = a.toInt(&ok, base);
    QVERIFY(ok == true);
    QVERIFY(v = v2);
}

void FoundationTest::testStringArg()
{
    QString name("Joe");
    QString weekday = QDate::currentDate().toString("dddd");
    QString hello = QString("Hello %1. Today is %2.").arg(name).arg(weekday);
    // This worked on Monday. Promise!
    if(Qt::Monday == QDate::currentDate().dayOfWeek()) {
        QCOMPARE(QString("Hello Joe. Today is Monday."), hello);
    } else {
        QVERIFY(QString("Hello Joe. Today is Monday.") !=  hello);
    }
}


void FoundationTest::testUnicode()
{
    QChar smile(0x263A);//);
    qDebug() << smile;
    QChar smile2 = QString("\u263A").at(0);
    QVERIFY(smile == smile2);
    QVector<QChar> smilies(12);
    smilies.fill(smile);
    qDebug() << smilies;
}

void FoundationTest::testContainer()
{
    QList<int> list{1,2};

    list << 3;

    { // Qt for each
        int sum(0);
        // Qt for each
        foreach (int v, list) {
            sum += v;
        }
        QVERIFY(sum == 6);
    }
    { // C++11 for each
        int sum = 0;
        for(int v : list) {
            sum+= v;
        }
        QVERIFY(sum == 6);
    }

    { // JAVA iterator
        int sum = 0;
        QListIterator<int> i(list);
        while (i.hasNext()) {
            sum += i.next();
        }
        QVERIFY(sum == 6);
    }

    { // STL iterator
        int sum = 0;
        QList<int>::iterator i;
        for (i = list.begin(); i != list.end(); ++i) {
            sum += *i;
        }
        QVERIFY(sum == 6);
    }


    // std::sort descending with mutable iterator using C++11
    std::sort(list.begin(), list.end(), [](int a, int b) { return a > b; });
    QVERIFY(list == QList<int>({3,2,1}));


    int value = 3;
    { // std::find with const iterator
        QList<int>::const_iterator result = std::find(list.constBegin(), list.constEnd(), value);
        QVERIFY(*result == value);
    }

    { // std::find using lambda and auto
        auto result = std::find_if(list.constBegin(), list.constBegin(), [value](int v) { return v == value; });
        QVERIFY(*result == value);
    }
}


void FoundationTest::testDictionary()
{
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
}

void FoundationTest::testFileIO()
{
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
}

QTEST_MAIN(FoundationTest)

#include "tst_foundation.moc"
