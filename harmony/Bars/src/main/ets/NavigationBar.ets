
/**
 * 导航栏状态修改组件
 */

import window from '@ohos.window';

@Component
export struct NavigationBar{
  //外界动态修改导航栏颜色实时监听
  @Prop @Watch("navigationBarStyleUpdateCallback") navigationBarStyle: string = 'light-content';

  navigationBarStyleUpdateCallback(){
    //外界动态修改导航栏颜色实时修改
    this.upNavigationBar();
  }

  //颜色取值逻辑
  getBarColorByType (): string {

    if(this.navigationBarStyle == 'light-content'){
      this.navigationBarStyle =  '#ffffffff';
    }else if(this.navigationBarStyle == 'dark-content'){
      this.navigationBarStyle =  '#ff000000';
    }

    return  this.navigationBarStyle;
  }

  //修改导航栏颜色
  upNavigationBar () {
    window.getLastWindow(getContext(this), (err, w) => {
      w.setWindowSystemBarProperties({
        // 状态栏颜色
        //   statusBarColor: '#66666666',
        // 状态栏文字颜色
        // statusBarContentColor:  this.getBarColorByType(),
        // 导航栏颜色
        //   navigationBarColor:'#ff000000',
        // 导航栏文字颜色
        navigationBarContentColor: this.getBarColorByType(),

      })
    })
  }

  aboutToAppear() {
    //初始化，执行修改导航栏内容颜色
    this.upNavigationBar();
  }

  build() {}
}