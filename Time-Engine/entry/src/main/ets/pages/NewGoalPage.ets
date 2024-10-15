import router from '@ohos.router'

@Entry
@Component
struct NewGoalPage {
  @State message: string = '';

  build(){
    Column({space:6}) {
      Text('back')
        .textAlign(TextAlign.Center)
        .backgroundImage($r('app.media.back'))
        .backgroundImagePosition(Alignment.Center)
        .backgroundImageSize({width:50,height:50})
        .width(50)
        .height(50)
        .position({x:30,y:20})
        .onClick(()=>{
          router.showAlertBeforeBackPage({ message: '你真的要退出吗' })
          router.back({
                url:'pages/TaskPage',
                params:{
                  NewGoal: 'None'
                }
              })
        })

      Row(){
        Image($r('app.media.NewGoal'))
          .width(30)
          .height(30)
          .position({x:10,y:10})

        Text('写下你的目标！')
          .textAlign(TextAlign.Center)
          .fontSize(20)
          .position({x:60,y:12})

      }
      .backgroundColor(Color.Pink)
      .width(250)
      .height(50)
      .borderRadius(20)
      .position({x:50,y:100})


      TextInput({ placeholder: '总目标' }).margin({ top: 20 })
        .onSubmit((EnterKeyType)=>{
          console.info(EnterKeyType+'创建')
        })
        .onChange((message)=>{
          this.message = message;
        })
        .width(250)
        .height(50)
        .backgroundColor(Color.Gray)
        .position({x:50,y:150})

      Button('创建目标：'+this.message)
        .fontColor(Color.Black)
        .width(300)
        .height(50)
        .backgroundColor(Color.White)
        .position({x:35,y:600})
        .onClick(()=>{
          router.back({
            url:'pages/TaskPage',
            params:{
              NewGoal: this.message
            }
          })
        })

    }
    .width('100%')
    .height('100%')
    .backgroundImage($r('app.media.background'))
    .backgroundImageSize(ImageSize.Cover)
  }
}