import {smallTask} from './Taskclass'

@Component
export default struct taskComponent{
  @ObjectLink
  sonTask: smallTask;

  @Builder
  CreateIcon(icon: Resource){
    Image(icon)
      .width(28)
      .height(28)
      .objectFit(ImageFit.Contain)
      .margin(20)
  }

  build() {
      Row() {
        if (this.sonTask.isFinish) {
          this.CreateIcon($r('app.media.is_finish'))
        } else {
          this.CreateIcon($r('app.media.is_unfinish'))
        }

        Text(this.sonTask.taskName)
          .fontSize(20)
          .fontWeight(500)
          .decoration({ type: this.sonTask.isFinish ? TextDecorationType.LineThrough : TextDecorationType.None })
          .opacity(this.sonTask.isFinish ? 0.5 : 1)

      }
      .borderRadius(24)
      .backgroundColor(Color.Grey)
      .width(300)
      .height(65)

    }
}