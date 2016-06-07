#ifndef FILEIO_H
#define FILEIO_H

#include <QtCore>

class FileIO : public QObject
{
    Q_OBJECT
    Q_DISABLE_COPY(FileIO)
    Q_PROPERTY(QUrl source READ source WRITE setSource NOTIFY sourceChanged)
    Q_PROPERTY(QString text READ text WRITE setText NOTIFY textChanged)
public:
    FileIO(QObject *parent = 0);
    ~FileIO();

    Q_INVOKABLE void read();
    Q_INVOKABLE void write();
    QUrl source() const;
    QString text() const;
public slots:
    void setSource(QUrl source);
    void setText(QString text);
signals:
    void sourceChanged(QUrl arg);
    void textChanged(QString arg);
private:
    QUrl m_source;
    QString m_text;
};

#endif // FILEIO_H

