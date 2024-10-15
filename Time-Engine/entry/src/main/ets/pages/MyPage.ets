import router from '@ohos.router';
import {TaskModel} from '../Task/Taskclass'
import {smallTask} from '../Task/Taskclass'

@Entry
@Component
struct MyPage {
  @State
  userName: string = '三剑客';
  @State
  finishGoal: number = 0;

  onPageShow(){
    let record = router.getParams() as Record<string, number>
    if(record){
    this.finishGoal = record['count']
  }
  }

  build() {
    Column({ space: 20 }) {

    Divider()

    Row(){
      Image($r('app.media.circle'))
        .width(60)
        .height(60)
        .position({x:25,y:20})

      Text('Hello~')
        .fontSize(30)
        .fontStyle(FontStyle.Italic)
        .fontWeight(FontWeight.Bold)
        .position({x:40,y:33})

      TextInput({ text: this.userName }).margin({ top: 20 })
        .fontSize(30)
        .fontWeight(FontWeight.Bold)
        .onSubmit((EnterKeyType)=>{
          console.info(EnterKeyType+'创建')
        })
        .onChange((message)=>{
          this.userName = message;
        })
        .width(170)
        .height(50)
        .backgroundColor(Color.White)
        .position({x:150, y:5})
    }
      .backgroundImage($r('app.media.taskBackGround'))
      .backgroundImageSize({width:340, height:100})
      .backgroundImagePosition(Alignment.Center)
      .height(100)
      .width(350)


      Image($r('app.media.done'))
        .width(50)
        .height(50)

      Text('你在时光引擎\n完成了'+(this.finishGoal-1).toString()+'项目标!!!')
        .fontSize(30)
        .fontWeight(FontWeight.Bold)

      Text('its time to fight!   its time to fight!')
        .textOverflow({overflow:TextOverflow.MARQUEE})
        .fontColor(Color.White)
        .fontSize(50)
        .fontWeight(FontWeight.Bold)
        .align(Alignment.Center)
        .position({y:400})

      Row() {
        Column() {
          Image($r('app.media.goal'))
            .width(100)
          Text('目标')
            .fontWeight(FontWeight.Bold)
        }
        .onClick(()=>{
          router.back({
            url:'pages/TaskPage'
          })
        })
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
      }
      .justifyContent(FlexAlign.SpaceBetween)
      .position({y:620})
      .width(350)

    }
    .backgroundImage($r('app.media.background'))
    .backgroundImageSize(1)
    .height('100%')
    .width('100%')
  }
}