#include "adaptivemodel.h"

AdaptiveModel::AdaptiveModel(QObject *parent)
    : QSortFilterProxyModel(parent)
    , m_sortOrder(Qt::AscendingOrder)
    , m_valueRole(Qt::UserRole)
{
}

AdaptiveModel::~AdaptiveModel()
{
}

// Returns true if the item in the row should be included in the model
bool AdaptiveModel::filterAcceptsRow(int source_row, const QModelIndex &source_parent) const
{
    if(m_filter.isNull() || !m_filter.isCallable()) {
        return QSortFilterProxyModel::filterAcceptsRow(source_row, source_parent);
    }
    QModelIndex index = sourceModel()->index(source_row, 0, source_parent);
    QJSValue value = sourceModel()->data(index, Qt::UserRole).value<QJSValue>();
    return m_filter.call(QJSValueList({value})).toBool();
}

// Returns true if referenced value of left is less than right
bool AdaptiveModel::lessThan(const QModelIndex &left, const QModelIndex &right) const
{
    if(m_predicate.isNull() || !m_predicate.isCallable()) {
        return QSortFilterProxyModel::lessThan(left, right);
    }
    QJSValue leftValue = left.model()->data(left, Qt::UserRole).value<QJSValue>();
    QJSValue rightValue = right.model()->data(right, Qt::UserRole).value<QJSValue>();
    return m_predicate.call(QJSValueList({leftValue, rightValue})).toBool();
}

void AdaptiveModel::applyFilter()
{
    qDebug() << "applyFilter()";
    invalidateFilter();
}

int AdaptiveModel::mapToSourceRow(int proxyRow) const
{
    return mapToSource(index(proxyRow, 0)).row();
}

int AdaptiveModel::mapFromSourceRow(int sourceRow) const
{
    return mapFromSource(sourceModel()->index(sourceRow, 0)).row();
}

void AdaptiveModel::applySort()
{
    sort(0, m_sortOrder);
}

QObject *AdaptiveModel::source() const
{
    return sourceModel();
}

QJSValue AdaptiveModel::filter() const
{
    return m_filter;
}

int AdaptiveModel::count() const
{
    return rowCount(QModelIndex());
}

QJSValue AdaptiveModel::sorter() const
{
    return m_predicate;
}

Qt::SortOrder AdaptiveModel::sortOrder() const
{
    return m_sortOrder;
}

void AdaptiveModel::setSource(QObject *source)
{
    QAbstractItemModel* model = qobject_cast<QAbstractItemModel*>(source);
    if(model && sourceModel() != model) {
        setSourceModel(model);
        emit sourceChanged(model);
    }
}

void AdaptiveModel::setFilter(QJSValue filter)
{
    if (m_filter.equals(filter)) {
        qDebug() << "xxx same filter";
        return;
    }

    m_filter = filter;
    emit filterChanged(filter);
    applyFilter();
}

void AdaptiveModel::setSorter(QJSValue predicate)
{
    if (m_predicate.equals(predicate)) {
        return;
    }

    m_predicate = predicate;
    emit sorterChanged(predicate);
    applySort();
}

void AdaptiveModel::setSortOrder(Qt::SortOrder order)
{
    if (m_sortOrder == order)
        return;
    m_sortOrder = order;
    emit sortOrderChanged(order);
    applySort();
}

void AdaptiveModel::setValueRole(QString roleName)
{
    if (m_valueRoleName == roleName)
        return;

    m_valueRoleName = roleName;
    emit valueRoleChanged(roleName);
}



QString AdaptiveModel::valueRole() const
{
    return m_valueRoleName;
}
