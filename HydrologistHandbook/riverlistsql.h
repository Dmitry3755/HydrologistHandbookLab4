#ifndef RIVERLISTSQL_H
#define RIVERLISTSQL_H

#include <QtSql>

class RiverListSql: public QSqlQueryModel
{
    Q_OBJECT

    Q_PROPERTY(QSqlQueryModel* riverModel READ getModel CONSTANT)
    Q_PROPERTY(bool IsConnectionOpen READ isConnectionOpen CONSTANT)

public:
  explicit  RiverListSql(QObject *parent);
  void refresh();
  QHash<int, QByteArray> roleNames() const override;
  QVariant data(const QModelIndex & index, int role = Qt::DisplayRole) const override;

  Q_INVOKABLE void add(const QString& name, const int lenght, const QString& fallsIn, const int annualRunoff, const int coolArea);
  Q_INVOKABLE void del(const int index);
  Q_INVOKABLE void edit(const QString& name, const int lenght, const QString& fallsIn, const int annualRunoff, const int coolArea, const int index);


signals:

public slots:

private:
    const static char* SQL_SELECT;
    QSqlDatabase db;
    QSqlQueryModel *getModel();
    bool _isConnectionOpen;
    bool isConnectionOpen();
};

#endif // RIVERLISTSQL_H
