import { systemDateTime } from '@kit.BasicServicesKit'

@Observed
export class smallTask{
  taskName: string
  isFinish: boolean
  creatDate: number

  constructor(taskName: string, isFinish: boolean) {
    this.taskName = taskName
    this.isFinish = isFinish
    this.creatDate = systemDateTime.getTime()
  }

  getName(): string{
    return this.taskName
  }

  getIsFinish(): boolean{
    return this.isFinish
  }
}

@Observed
export class TaskModel{
  goalName: string;
  id: number;
  goalCount: number = 0;
  taskList: Array<smallTask> = [
  // new smallTask('goal',false)
  ]
  updateTime: number = 0;


  constructor(id: number,updateTime: number,totalTask: string) {
    this.id = id;
    this.updateTime = updateTime
    this.goalName = totalTask;
  }

  addTask(taskName:string): void{
    this.taskList.push(new smallTask(taskName,false))
  }

   getData(): Array<smallTask>{
    return this.taskList
   }

   getName(): string{
    return this.goalName
   }

   getGoalCount(): number{
    return this.taskList.length
   }

  getFinishCount(): number{
    let count: number = 0;
    for(let i: number = 0;i<this.taskList.length;i++){
      if(this.taskList[i].isFinish === true){
        count++;
      }
    }
    return count;
  }

 }