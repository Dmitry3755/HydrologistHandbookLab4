#include "riverlistsql.h"
#include "QObject"

RiverListSql::RiverListSql(QObject *parent) :
    QSqlQueryModel(parent)
{
     QSqlDatabase::removeDatabase("myConnection");

     db = QSqlDatabase::addDatabase("QSQLITE", "myConnection");
     db.setDatabaseName("Rivers.sqlite3");

      _isConnectionOpen = true;

     if(!db.open())
     {
         qDebug() << db.lastError().text();
         _isConnectionOpen = false;
     }

     QSqlQuery qry(db);
     qry.prepare( "CREATE TABLE IF NOT EXISTS Rivers (Id INTEGER UNIQUE PRIMARY KEY AUTOINCREMENT, Name VARCHAR(150), Lenght INTEGER, FallsIn  VARCHAR(150), AnnualRunoff INTEGER, CoolArea INTEGER )" );
     if( !qry.exec() )
     {
         qDebug() << db.lastError().text();
         _isConnectionOpen = false;
     }



     refresh();
 }

 QSqlQueryModel* RiverListSql::getModel(){
     return this;
 }
 bool RiverListSql::isConnectionOpen(){
     return _isConnectionOpen;
 }
 QHash<int, QByteArray> RiverListSql::roleNames() const
 {
     QHash<int, QByteArray> roles;
     roles[Qt::UserRole + 1] = "Id";
     roles[Qt::UserRole + 2] = "Name";
     roles[Qt::UserRole + 3] = "Lenght";
     roles[Qt::UserRole + 4] = "FallsIn";
     roles[Qt::UserRole + 5] = "AnnualRunoff";
     roles[Qt::UserRole + 6] = "CoolArea";

     return roles;
 }


 QVariant RiverListSql::data(const QModelIndex &index, int role) const
 {
     QVariant value = QSqlQueryModel::data(index, role);
     if(role < Qt::UserRole-1)
     {
         value = QSqlQueryModel::data(index, role);
     }
     else
     {
         int columnIdx = role - Qt::UserRole - 1;
         QModelIndex modelIndex = this->index(index.row(), columnIdx);
         value = QSqlQueryModel::data(modelIndex, Qt::DisplayRole);
     }
     return value;
 }

 const char* RiverListSql::SQL_SELECT =
         "SELECT Rivers.Id, Rivers.Name, Rivers.Lenght, Rivers.FallsIn, Rivers.AnnualRunoff, Rivers.CoolArea"
         " FROM Rivers";

 void RiverListSql::refresh()
 {
     this->setQuery(RiverListSql::SQL_SELECT,db);
 }

 void RiverListSql::add(const QString& name, const int lenght, const QString& fallsIn, const int annualRunoff, const int coolArea) {

     QSqlQuery query(db);
     QString strQuery= QString("INSERT INTO Rivers (Name,Lenght,FallsIn,AnnualRunoff, CoolArea) VALUES ('%1', %2, '%3',%4, %5)")
             .arg(name)
             .arg(lenght)
             .arg(fallsIn)
             .arg(annualRunoff)
             .arg(coolArea);
        query.exec(strQuery);

     refresh();
 }

 void RiverListSql::edit(const QString& name, const int lenght, const QString& fallsIn, const int annualRunoff, const int coolArea, const int Id){

     QSqlQuery query(db);
     QString strQuery= QString("UPDATE Rivers SET Name = '%1',Lenght = %2,FallsIn = '%3', AnnualRunoff = %4, CoolArea = %5 WHERE Id = %6")
             .arg(name)
             .arg(lenght)
             .arg(fallsIn)
             .arg(annualRunoff)
             .arg(coolArea)
             .arg(Id);
     query.exec(strQuery);

     refresh();

 }
 void RiverListSql::del(const int Id){


     QSqlQuery query(db);
     QString strQuery= QString("DELETE FROM Rivers WHERE Id = %1")
             .arg(Id);
     query.exec(strQuery);

     refresh();
}
