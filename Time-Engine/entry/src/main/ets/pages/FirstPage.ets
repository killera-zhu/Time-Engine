import router from '@ohos.router';

@Entry
@Component
struct FirstPage {
  @State message: string = '';

  build() {
      Column({space:50}) {
        Divider()

        Text('你好，时光引擎')
          .fontColor(Color.Blue)
          .fontSize(48)
          .fontWeight(FontWeight.Bold)
          .fontStyle(FontStyle.Italic)
          .alignRules({
            center: { anchor: '__container__', align: VerticalAlign.Center },
            middle: { anchor: '__container__', align: HorizontalAlign.Center }
          })

        Text('its time to fight!   its time to fight!')
          .textOverflow({overflow:TextOverflow.MARQUEE})
          .fontColor(Color.White)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
          .align(Alignment.Center)
          .position({y:260})

        Button('进入')
          .fontSize(25)
          .position({x:200,y:500})
          .height(50)
          .width(100)
          .onClick(()=>{
            router.pushUrl({ url: 'pages/TaskPage' })
        })
      }
      .align(Alignment.Center)
      .backgroundImage($r('app.media.background'))
      .backgroundImageSize(ImageSize.Cover)
      .height('100%')
      .width('100%')
  }
}