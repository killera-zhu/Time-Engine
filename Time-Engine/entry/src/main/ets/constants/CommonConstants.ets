import relationalStore from '@ohos.data.relationalStore'

interface TaskTable {
  tableName: string
  sqlCreate: string
  columns: string[]
}

export default class CommonConstants {

  // Rdb 数据库配置
  static readonly STORE_CONFIG:relationalStore.StoreConfig = {
    name:'database.db',
    securityLevel:relationalStore.SecurityLevel.S1
  }

  static readonly MEMO_TABLE:TaskTable = {
    tableName:'taskTable',
    sqlCreate:'CREATE TABLE IF NOT EXISTS taskTable(id INTEGER PRIMARY KEY AUTOINCREMENT, updateTime INTEGER, goalName TEXT,taskName1 TEXT,taskName2 TEXT,taskName3 TEXT,taskName4 TEXT,taskName5 TEXT,taskName6 TEXT,taskName7 TEXT,taskName8 TEXT,taskName9 TEXT,taskName10 TEXT)',
    columns:['id','updateTime','goalName','taskName1','taskName2','taskName3','taskName4','taskName5','taskName6','taskName7','taskName8','taskName9','taskName10']
  }

  static readonly RDB_TAG = '[Debug.Rdb]';
  static readonly TABLE_TAG = '[Debug.memoTable]';
  static readonly INDEX_TAG = '[Debug.Index]';

}