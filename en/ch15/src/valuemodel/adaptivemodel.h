#ifndef ADAPTIVEMODEL_H
#define ADAPTIVEMODEL_H

#include <QtCore>
#include <QtQml>

class AdaptiveModel : public QSortFilterProxyModel
{
    Q_OBJECT
    Q_PROPERTY(QObject* source READ source WRITE setSource NOTIFY sourceChanged)
    Q_PROPERTY(QJSValue filter READ filter WRITE setFilter NOTIFY filterChanged)
    Q_PROPERTY(QJSValue sorter READ sorter WRITE setSorter NOTIFY sorterChanged)
    Q_PROPERTY(Qt::SortOrder sortOrder READ sortOrder WRITE setSortOrder NOTIFY sortOrderChanged)
    Q_PROPERTY(int count READ count NOTIFY countChanged)
    Q_PROPERTY(QString valueRole READ valueRole WRITE setValueRole NOTIFY valueRoleChanged)
    Q_CLASSINFO("DefaultProperty", "source")

public:
    explicit AdaptiveModel(QObject *parent = 0);
    ~AdaptiveModel();

    bool filterAcceptsRow(int source_row, const QModelIndex &source_parent) const;
    bool lessThan(const QModelIndex &left, const QModelIndex &right) const;

    Q_INVOKABLE void applyFilter();
    Q_INVOKABLE int mapToSourceRow(int proxyRow) const;
    Q_INVOKABLE int mapFromSourceRow(int sourceRow) const;
    Q_INVOKABLE void applySort();

    QObject* source() const;
    QJSValue filter() const;

    int count() const;

    QJSValue sorter() const;

    Qt::SortOrder sortOrder() const;

    QString valueRole() const;

public slots:
    void setSource(QObject* source);
    void setFilter(QJSValue filter);
    void setSorter(QJSValue predicate);
    void setSortOrder(Qt::SortOrder order);
    void setValueRole(QString roleName);

signals:
    void sourceChanged(QObject* source);
    void filterChanged(QJSValue filter);
    void countChanged(int count);
    void sorterChanged(QJSValue sorter);
    void sortOrderChanged(Qt::SortOrder order);
    void valueRoleChanged(QString roleName);

private:
    mutable QJSValue m_filter;
    mutable QJSValue m_predicate;
    Qt::SortOrder m_sortOrder;
    QString m_valueRoleName;
    int m_valueRole;
};



#endif // ADAPTIVEMODEL_H
