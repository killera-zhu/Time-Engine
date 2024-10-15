import relationalStore from '@ohos.data.relationalStore';
import { TaskModel } from '../Task/Taskclass'
import CommonConstants from '../constants/CommonConstants';
import Rdb from './Rdb';

export default class taskTable {
  private taskTable = new Rdb(CommonConstants.MEMO_TABLE.tableName, CommonConstants.MEMO_TABLE.sqlCreate,
    CommonConstants.MEMO_TABLE.columns);

  constructor(callback: Function = () => {
  }) {
    this.taskTable.getRdbStore(callback);
  }
  getRdbStore(callback: Function = () => {
  }) {
    // 透传回调函数
    this.taskTable.getRdbStore(callback);
  }


  insertData(task: TaskModel, callback: Function) {
    // 通过工具函数，将单条memo笔记，转化为存储健值对
    const valueBucket: relationalStore.ValuesBucket = generateBucket(task);
    // 执行memoTable的插入数据方法，透传回调函数
    this.taskTable.insertData(valueBucket, callback);
  }

  // 删除数据的方法，接收单条memo笔记对象，和回调函数
  deleteData(task: TaskModel, callback: Function) {
    // 初始化操作数据库的谓词对象
    let predicates = new relationalStore.RdbPredicates(CommonConstants.MEMO_TABLE.tableName);
    // 配置谓词以匹配数据表的id列中值的字段，为笔记对象的id
    predicates.equalTo('id', task.id);
    // 使用谓词执行memoTable的删除方法，透传回调函数
    this.taskTable.deleteData(predicates, callback);
  }

  // 更新数据的方法，接收单条memo笔记对象，和回调函数
  updateData(task: TaskModel, callback: Function) {
    // 通过工具函数，将单条memo笔记，转化为存储健值对
    const valueBucket: relationalStore.ValuesBucket = generateBucket(task);
    // 初始化操作数据库的谓词对象
    let predicates = new relationalStore.RdbPredicates(CommonConstants.MEMO_TABLE.tableName);
    // 配置谓词以匹配数据表的id列中值的字段，为笔记对象的id
    predicates.equalTo('id', task.id);
    // 使用谓词执行memoTable的更新方法，透传回调函数
    this.taskTable.updateData(predicates, valueBucket, callback);
  }

  // 查询全部笔记的方法
  query(callback: Function) {
    // 初始化操作数据库的谓词对象
    let predicates = new relationalStore.RdbPredicates(CommonConstants.MEMO_TABLE.tableName);
    // 使用谓词执行memoTable的查询方法，此时谓词匹配未指定（equalTo），所以将查询全部
    this.taskTable.query(predicates, (resultSet: relationalStore.ResultSet) => {
      // 创建局部变量，存储结果的行数
      let count: number = resultSet.rowCount;
      // 如果查询的结果为0，执行回调函数，传入空数组
      if (count === 0 || typeof count === 'string') {
        console.log(`${CommonConstants.TABLE_TAG}` + 'Query no results!');
        callback([]);
      } else {
        // 如果有结果，将结果集指向第一行
        resultSet.goToFirstRow();
        // 创建局部变量，存储最后将返回的结果数组
        const result: TaskModel[] = [];
        // 使用循环为结果添加内容
        for (let i = 0; i < count; i++) {
          let tmp: TaskModel = new TaskModel(0,0,'')
          tmp.id = resultSet.getDouble(resultSet.getColumnIndex('id'));
          tmp.updateTime = resultSet.getDouble(resultSet.getColumnIndex('updateTime'));
          tmp.goalName = resultSet.getString(resultSet.getColumnIndex('goalName'));
          tmp.taskList[0].taskName = resultSet.getString(resultSet.getColumnIndex('taskName1'));
          result[i] = tmp;
          // 转至下一行
          resultSet.goToNextRow();
        }
        // 执行回调函数，把所有的查询结果传入
        callback(result);
      }
    });
  }
}

// 工具函数，将memo笔记的数据结构，转化为存储键值对
function generateBucket(task: TaskModel): relationalStore.ValuesBucket {
  let obj: relationalStore.ValuesBucket = {};
  obj.goalName = task.goalName;
  obj.updateTime = task.updateTime
  obj.taskName1 = task.taskList[0].taskName

  return obj;
}