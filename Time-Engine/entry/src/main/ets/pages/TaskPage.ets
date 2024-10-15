import router from '@ohos.router';
import {TaskModel} from '../Task/Taskclass'
import {smallTask} from '../Task/Taskclass'
import taskComponent from '../Task/Taskcompoment'


@CustomDialog
struct CustomDialogExample {
  @Link newGoal: string;
  @Link reload: boolean;
  controller?: CustomDialogController
  confirm: () => void = () => {
  }
  value: string = '';

  build() {
    Column({ space: 20 }) {
      Text('请输入新的子任务')
      TextInput({ placeholder: '', text: this.value }).height(60).width('90%')
        .onChange((value: string) => {
          this.value = value
        })
      Row({ space: 50 }) {
        Button('取消')
          .onClick(() => {
            if (this.controller != undefined) {
              this.controller.close()
            }
          })
        Button('确认')
          .onClick(() => {
            if (this.controller != undefined) {
              this.newGoal = this.value
              this.reload = !this.reload
              this.controller.close()
              this.confirm()
            }
          })

      }.padding(20)
    }
  }
}


@Entry
@Component
struct TaskListIndex{
  @State
  private myTaskList: Array<TaskModel> = [];
  @State
  private  thisTaskNumber: number = 0;
  @State
  private NewGoal: string = '';
  @State
  private thisGoal: string = '';
  // @State
  // private myTask: TaskModel = new TaskModel(0,0,this.thisGoal);
  @State
  private myFinishNumber: number = 0;
  @State
  private myTaskNumber : number = 0;
  @State
  private taskNumberArray: Array<number> = [];
  @State
  private newGoal: string = 'goal';
  @State
  private oldGoal: string = 'goal';
  @State
  private reload: boolean = true;

  aboutToAppear(){
    let record = router.getParams() as Record<string, string>
    if(record){
      this.NewGoal = record['NewGoal']
    }
    this.myTaskList[this.thisTaskNumber] = new TaskModel(0,0,this.thisGoal)
    this.myFinishNumber = this.myTaskList[this.thisTaskNumber].getFinishCount();
    this.myTaskNumber = this.myTaskList[this.thisTaskNumber].getGoalCount();
    for(let i = 0;i<this.myTaskNumber;i++){
      this.taskNumberArray[i] = i;
    }
  }

  onPageShow(){
    let record = router.getParams() as Record<string, string>
    if(record) {
      this.NewGoal = record['NewGoal']
      if (this.NewGoal != this.thisGoal && this.NewGoal != 'None') {
        this.myTaskNumber = this.myTaskList[this.thisTaskNumber].getGoalCount();
        for (let i = 0; i < this.myTaskNumber; i++) {
          this.taskNumberArray.pop()
        }
        this.thisTaskNumber = this.myTaskList.length
        this.myTaskList[this.thisTaskNumber] = new TaskModel(0, 0, this.NewGoal)
        this.myFinishNumber = this.myTaskList[this.thisTaskNumber].getFinishCount();
        this.myTaskNumber = this.myTaskList[this.thisTaskNumber].getGoalCount();
        for (let i = 0; i < this.myTaskNumber; i++) {
          this.taskNumberArray[i] = i;
        }
        this.oldGoal = this.NewGoal
        this.reload = !this.reload
      }
    }
  }

  dialogController: CustomDialogController | null = new CustomDialogController({
    builder: CustomDialogExample({
      confirm: ()=> { this.onAccept() },
      newGoal: $newGoal,
      reload:  $reload
    }),
    cancel: this.exitApp,
    autoCancel: true,
    onWillDismiss:(dismissDialogAction: DismissDialogAction)=> {
      console.info("reason=" + JSON.stringify(dismissDialogAction.reason))
      console.log("dialog onWillDismiss")
      if (dismissDialogAction.reason == DismissReason.PRESS_BACK) {
        dismissDialogAction.dismiss()
      }
      if (dismissDialogAction.reason == DismissReason.TOUCH_OUTSIDE) {
        dismissDialogAction.dismiss()
      }
    },
    alignment: DialogAlignment.Bottom,
    offset: { dx: 0, dy: -20 },
    gridCount: 4,
    customStyle: false,
    cornerRadius: 10,
  })

  aboutToDisappear() {
    this.dialogController = null
  }

  onCancel() {
    console.info('Callback when the first button is clicked')
  }

  onAccept() {
    console.info('Callback when the second button is clicked')
    if(this.newGoal != this.oldGoal)
    {
      let i = this.taskNumberArray.length;
      this.taskNumberArray[i] = i
      this.myTaskList[this.thisTaskNumber].addTask(this.newGoal);
      this.oldGoal = this.newGoal
    }
    this.myFinishNumber = this.myTaskList[this.thisTaskNumber].getFinishCount();
    this.myTaskNumber = this.myTaskList[this.thisTaskNumber].getGoalCount();
  }

  exitApp() {
    console.info('Click the callback in the blank area')
  }

  build() {
    Column({space:6}) {
      Divider()
      Row(){
        Button()
          .onClick(()=>{
            if(this.thisTaskNumber > 0){
              this.myTaskNumber = this.myTaskList[this.thisTaskNumber].getGoalCount();
              for (let i = 0; i < this.myTaskNumber; i++) {
                this.taskNumberArray.pop()
              }
              this.thisTaskNumber--;
              this.reload = !this.reload
              this.myFinishNumber = this.myTaskList[this.thisTaskNumber].getFinishCount();
              this.myTaskNumber = this.myTaskList[this.thisTaskNumber].getGoalCount();
              for (let i = 0; i < this.myTaskNumber; i++) {
                this.taskNumberArray[i] = i;
              }
            }
          })
          .width(50)
          .height(50)
          .backgroundImage($r('app.media.left'))
          .backgroundImageSize({ width:40,height:40 })
          .backgroundImagePosition(Alignment.Center)
          .backgroundColor(Color.White)
        Column() {
          Text('正在进行中的目标：')
            .textAlign(TextAlign.Center)
            .fontSize(10)
          Text(this.myTaskList[this.thisTaskNumber].goalName)
            .textAlign(TextAlign.Center)
            .fontSize(30)
            .fontWeight(FontWeight.Bold)
          }
        Button()
          .onClick(()=>{
            if(this.thisTaskNumber < this.myTaskList.length-1){
              this.myTaskNumber = this.myTaskList[this.thisTaskNumber].getGoalCount();
              for (let i = 0; i < this.myTaskNumber; i++) {
                this.taskNumberArray.pop()
              }
              this.thisTaskNumber++;
              this.reload = !this.reload
              this.myFinishNumber = this.myTaskList[this.thisTaskNumber].getFinishCount();
              this.myTaskNumber = this.myTaskList[this.thisTaskNumber].getGoalCount();
              for (let i = 0; i < this.myTaskNumber; i++) {
                this.taskNumberArray[i] = i;
              }
            }
          })
          .width(50)
          .height(50)
          .backgroundImage($r('app.media.right'))
          .backgroundImageSize({ width:40,height:40 })
          .backgroundImagePosition(Alignment.Center)
          .backgroundColor(Color.White)
      }
      .justifyContent(FlexAlign.SpaceEvenly)
      .width(365)
      .height(70)
      .backgroundImage($r('app.media.taskBackGround'))
      .backgroundImageSize({ width: 365, height: 70 })



      Progress({ value: this.myFinishNumber, total: this.myTaskNumber, type: ProgressType.Linear })
        .width(300)
        .height(100)
        .style({ strokeWidth: 15 })

      Divider()

      Column() {
        Scroll() {
          Column({ space: 6 }) {
            if(this.reload){
            ForEach(this.taskNumberArray, (index: number) => {
              taskComponent({
                sonTask: this.myTaskList[this.thisTaskNumber].getData()[index] as smallTask
              })
                .onClick(() => {
                  if (this.myTaskList[this.thisTaskNumber].getData()[index].isFinish === true) {
                    this.myTaskList[this.thisTaskNumber].getData()[index].isFinish = false
                    this.myFinishNumber--;
                  } else {
                    this.myTaskList[this.thisTaskNumber].getData()[index].isFinish = true
                    this.myFinishNumber++;
                  }
                })
            })}
            else{
              ForEach(this.taskNumberArray, (index: number) => {
                taskComponent({
                  sonTask: this.myTaskList[this.thisTaskNumber].getData()[index] as smallTask
                })
                  .onClick(() => {
                    if (this.myTaskList[this.thisTaskNumber].getData()[index].isFinish === true) {
                      this.myTaskList[this.thisTaskNumber].getData()[index].isFinish = false
                      this.myFinishNumber--;
                    } else {
                      this.myTaskList[this.thisTaskNumber].getData()[index].isFinish = true
                      this.myFinishNumber++;
                    }
                  })
              })
            }


          }
        }
        .width(300)
        .height(360)
        .align(Alignment.Center)
        .position({x:20,y:20})
      }
      .width(330)
      .height(400)
      .backgroundImage($r('app.media.TaskListBackGround'))
      .backgroundImageSize(1)

      Row(){
        Button('新增子任务')
          .width(100)
          .height(40)
           .onClick(() => {
            if(this.dialogController != null)
             this.dialogController.open();
           })

        Button('新增总目标')
          .width(100)
          .height(40)
          .onClick(()=>{
            router.pushUrl({ url: 'pages/NewGoalPage' })
          })
        }
        .justifyContent(FlexAlign.SpaceBetween)
        .width(350)

      Row() {
        Column() {
          Image($r('app.media.goal'))
            .width(100)
          Text('目标')
            .fontWeight(FontWeight.Bold)
        }
        .backgroundImage($r('app.media.goalBackGround'))
        .backgroundImageSize({width:200,height:60})
        .width(150)
        .height(60)

        Column() {
          Image($r('app.media.my'))
            .width(100)
          Text('我的')
            .fontWeight(FontWeight.Bold)
        }
        .backgroundImage($r('app.media.myBackGround'))
        .backgroundImageSize({width:150,height:60})
        .width(150)
        .height(60)
        .onClick(()=>{
          let count = 0;
          for (let i = 0;i<this.myTaskList.length;i++){
            if(this.myTaskList[i].getGoalCount() === this.myTaskList[i].getFinishCount()){
              count++;
            }
          }

          router.pushUrl({
            url: 'pages/MyPage',
            params:{
              count: count
            }
          })
        })
      }
      .justifyContent(FlexAlign.SpaceBetween)
      .width(350)
    }
    .width('100%')
    .height('100%')
    .backgroundImage($r('app.media.background'))
    .backgroundImageSize(ImageSize.Cover)
  }
}