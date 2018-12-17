#include "valuemodel.h"

ValueModel::ValueModel(QObject *parent)
    : QAbstractListModel(parent)
{
    m_roles[ObjectRole] = "object";
}

ValueModel::~ValueModel()
{
}

// clear model
void ValueModel::clear()
{
    if(m_data.isEmpty()) {
        return;
    }
    beginRemoveRows(QModelIndex(), 0, m_data.count() - 1);
    m_data.clear();
    endRemoveRows();
    emit countChanged(m_data.count());
}

// insert value at row
void ValueModel::insert(int row, const QJSValue &value)
{
    beginInsertRows(QModelIndex(), row, row);
    m_data.insert(row, value);
    endInsertRows();
    emit countChanged(m_data.count());
}

// append value at end
void ValueModel::append(const QJSValue &value)
{
    insert(count(), value);
}

// remove value from model
void ValueModel::remove(int row, int n)
{
    if (row < 0 || row >= m_data.count()) {
        return;
    }
    beginRemoveRows(QModelIndex(), row, row + n - 1);
    for (int i = 0; i < n; ++i) {
        m_data.removeAt(row);
    }
    endRemoveRows();
    emit countChanged(count());
}

// refresh a single row
void ValueModel::refreshRow(int row)
{
    emit dataChanged(index(row), index(row));
}

// refresh all rows in a delayed call
void ValueModel::refresh()
{
    QMetaObject::invokeMethod(this, "refreshDelayed", Qt::QueuedConnection);
}

// get the value at a row
QJSValue ValueModel::get(int row) const
{
    if (row < 0 || row >= m_data.count()) {
        return QJSValue();
    }
    return m_data.at(row);
}

// get all entries (this is costly call)
QJSValue ValueModel::getList() const
{
    QJSValue array = qmlEngine(this)->newArray(m_data.count());
    for(int i=0; i<m_data.count(); i++) {
        array.setProperty(i, m_data.at(i));
    }
    return array;
}

// replaces a value at row
void ValueModel::set(int row, const QJSValue &value)
{
    if (row < 0 || row >= m_data.count()) {
        return;
    }
    m_data.replace(row, value);
    emit dataChanged(this->index(row), this->index(row));
}

// set a property on a row
void ValueModel::setProperty(int row, const QString &name, const QJSValue &value)
{
    get(row).setProperty(name, value);
    emit dataChanged(this->index(row), this->index(row));
}

// move a row to another position
void ValueModel::move(int fromRow, int toRow)
{
    if(fromRow < 0 || toRow < 0 || fromRow >= m_data.count() || toRow >= m_data.count()) {
        return;
    }
    if (!beginMoveRows(QModelIndex(), fromRow, fromRow, QModelIndex(), toRow > fromRow ? toRow+1 : toRow)) {
        return;
    }
    m_data.move(fromRow, toRow);
    endMoveRows();
}

// find value using a callback
int ValueModel::find(QJSValue callback, int fromRow) const
{
    if(!callback.isCallable()) {
        return -1;
    }
    if(fromRow < 0 || fromRow >= m_data.count()) {
        return -1;
    }

    for(int i=fromRow; i<m_data.count(); i++) {
        QJSValue value = get(i);
        QJSValueList args({ value });
        if(callback.call(args).toBool()) {
            return i;
        }
    }
    return -1;
}

// find a specific value
int ValueModel::indexOf(const QJSValue &value, int fromRow) const
{
    if(fromRow < 0 || fromRow >= m_data.count()) {
        return -1;
    }
    for(int i=fromRow; i<m_data.count(); i++) {
        if(get(i).equals(value)) {
            return i;
        }
    }
    return -1;
}

// QQmlListProperty accesssor
QQmlListProperty< QObject > ValueModel::children()
{
    return QQmlListProperty< QObject >(this, 0,
                                       &ValueModel::append_children,
                                       &ValueModel::count_children,
                                       &ValueModel::at_children,
                                       &ValueModel::clear_children);
}


// QAbstractItemModel row count
int ValueModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent)
    return count();

}
// QAbstractItemModel data
QVariant ValueModel::data(const QModelIndex &index, int role) const
{
    int row = index.row();
    if (row < 0 || row >= m_data.count()) {
        return QVariant();
    }

    switch(role) {
    case ObjectRole:
        return QVariant::fromValue(m_data.at(row));
    }
    return QVariant();
}

// count property
int ValueModel::count() const
{
    return m_data.count();
}

// QAbstractItemModel role names
QHash<int, QByteArray> ValueModel::roleNames() const
{
    return m_roles;
}

// QQmlListProperty append
void ValueModel::append_children(QQmlListProperty< QObject >* property, QObject* object)
{
    ValueModel* model = qobject_cast< ValueModel* >(property->object);
    if(model) {
        object->setParent(model);
        QJSValue value = qmlEngine(model)->newQObject(object);
        model->append(value);
    }
}

// QQmlListProperty count
int ValueModel::count_children(QQmlListProperty< QObject >* property)
{
    ValueModel* model = qobject_cast< ValueModel* >(property->object);
    if(model) {
        return model->count();
    }
    return 0;
}

// QQmlListProperty at
QObject* ValueModel::at_children(QQmlListProperty< QObject >* property, int row)
{
    ValueModel* model = qobject_cast< ValueModel* >(property->object);
    if(model)
    {
        QJSValue value = model->get(row);
        return value.toQObject();
    }
    return 0;
}

// QQmlListProperty clear
void ValueModel::clear_children(QQmlListProperty< QObject >* property)
{
    ValueModel* model = qobject_cast< ValueModel* >(property->object);
    if(model) {
        model->clear();
    }
}

// refresh model by doing a reset
void ValueModel::refreshDelayed()
{
    beginResetModel();
    endResetModel();
}


