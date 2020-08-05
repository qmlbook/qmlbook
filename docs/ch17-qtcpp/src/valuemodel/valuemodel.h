#ifndef OBJECTLISTMODEL_H
#define OBJECTLISTMODEL_H

#include <QtCore>
#include <QtQml>

class ValueModel : public QAbstractListModel
{
    Q_OBJECT
    Q_PROPERTY(int count READ count NOTIFY countChanged)
    Q_PROPERTY(QQmlListProperty<QObject> children READ children NOTIFY countChanged)
    Q_CLASSINFO("DefaultProperty", "children")

public:
    explicit ValueModel(QObject *parent = 0);
    ~ValueModel();

    enum Roles { ObjectRole = Qt::UserRole };

    Q_INVOKABLE void clear();
    Q_INVOKABLE void insert(int row, const QJSValue &value);
    Q_INVOKABLE void append(const QJSValue &value);
    Q_INVOKABLE void remove(int row, int n=1);
    Q_INVOKABLE void refreshRow(int row);
    Q_INVOKABLE void refresh();

    Q_INVOKABLE QJSValue get(int row) const;
    Q_INVOKABLE QJSValue getList() const;
    Q_INVOKABLE void set(int row, const QJSValue &value);
    Q_INVOKABLE void setProperty(int row, const QString& name, const QJSValue &value);
    Q_INVOKABLE void move(int fromRow, int toRow);

    Q_INVOKABLE int find(QJSValue callback, int fromRow=0) const;
    Q_INVOKABLE int indexOf(const QJSValue& value, int fromRow=0) const;
    QQmlListProperty<QObject> children();


public:
    virtual int rowCount(const QModelIndex &parent) const;
    virtual QVariant data(const QModelIndex &index, int role) const;
    int count() const;
protected:
    QHash<int, QByteArray> roleNames() const;
private:
    static void append_children(QQmlListProperty<QObject> * property, QObject* object);
    static QObject *at_children(QQmlListProperty<QObject> *property, int row);
    static int count_children(QQmlListProperty<QObject> * property);
    static void clear_children(QQmlListProperty<QObject> * property);
private slots:
    void refreshDelayed();
signals:
    void countChanged(int count);
private:
    QJSValueList m_data;
    QHash<int, QByteArray> m_roles;
};

#endif // OBJECTLISTMODEL_H
