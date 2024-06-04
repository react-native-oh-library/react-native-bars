
/**
 * 状态栏状态修改组件
 */

import window from '@ohos.window';

@Component
export struct StatusBar{
  //外界动态修改状态栏颜色实时监听
  @Prop @Watch("statusBarStyleUpdateCallback") statusBarStyle: string = 'light-content';

  statusBarStyleUpdateCallback(){
    //外界动态修改状态栏颜色实时修改
    this.upStatusBar();
  }

  //颜色取值逻辑
  getBarColorByType (): string {

  if(this.statusBarStyle == 'light-content'){
    this.statusBarStyle =  '#ffffffff';
  }else if(this.statusBarStyle == 'dark-content'){
    this.statusBarStyle =  '#ff000000';
  }

    return  this.statusBarStyle;
  }

  //修改状态栏颜色
  upStatusBar () {
  window.getLastWindow(getContext(this), (err, w) => {
  w.setWindowSystemBarProperties({
  // 状态栏颜色
  //   statusBarColor: '#66666666',
  // 状态栏文字颜色
  statusBarContentColor:  this.getBarColorByType(),
  // 导航栏颜色
  //   navigationBarColor:'#ff000000',
  // 导航栏文字颜色
  // navigationBarContentColor: '#66666666',

  })
  })
  }

  aboutToAppear() {
    //初始化，执行修改状态栏内容颜色
    this.upStatusBar();
  }

  build() {}
}
