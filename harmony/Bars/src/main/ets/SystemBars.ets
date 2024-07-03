
/**
 * 系统状态修改组件
 */

import { StatusBar } from './StatusBar'
import { NavigationBar } from './NavigationBar'

@Component
export  struct SystemBars{
  //外界动态修改系统状态颜色
  @Prop barStyle: string = 'light-content';


  build() {
    Column() {
      StatusBar({barStyle: this.barStyle })
      NavigationBar({barStyle: this.barStyle })
    }
  }
}
