
/**
 * 导航栏状态修改组件
 */

import window from '@ohos.window';
import { NavigationBarProps } from "./types";


function  createStackEntry(entry: NavigationBarProps): NavigationBarProps {
  if(!entry?.barStyle){
    entry.barStyle = 'light-content'
  }
  return entry;
}
@Component
export  struct NavigationBar{
  //外界动态修改导航栏颜色实时监听
  @Prop @Watch("navigationBarStyleUpdateCallback") barStyle: string = 'light-content';

  private static propsStack: NavigationBarProps[] = [];
  private static timeOut: number | null = null;
  private static mergedProps: NavigationBarProps | null = null;
  private static target: NavigationBar;

  static pushStackEntry(props: NavigationBarProps): NavigationBarProps {
    const entry = createStackEntry(props);
    NavigationBar.propsStack.push(entry);
    NavigationBar.updatePropsStack();
    return entry;
  }

  static popStackEntry(entry: NavigationBarProps): void {
    const index = NavigationBar.propsStack.indexOf(entry);
    if (index !== -1) {
      NavigationBar.propsStack.splice(index, 1);
    }
    NavigationBar.updatePropsStack();
  }

  static replaceStackEntry(
    entry: NavigationBarProps,
    props: NavigationBarProps,
  ): NavigationBarProps {
    const newEntry = createStackEntry(props);
    const index = NavigationBar.propsStack.indexOf(entry);
    if (index !== -1) {
      NavigationBar.propsStack[index] = newEntry;
    }
    NavigationBar.updatePropsStack();
    return newEntry;
  }

  private static updatePropsStack() {
    // Send the update to the native module only once at the end of the frame.
    if (NavigationBar.timeOut !== null) {
      clearTimeout(NavigationBar.timeOut);
    }

    NavigationBar.timeOut = setTimeout(() => {
      const oldProps = NavigationBar.mergedProps;
      const lastEntry =
        NavigationBar.propsStack[NavigationBar.propsStack.length - 1];

      if (lastEntry != null) {
        // Update only if style have changed or if current props are unavailable.
        if ( oldProps?.barStyle !== lastEntry.barStyle) {
         //todo
          NavigationBar.upNavigationBar();
        }
        // Update the current props values.
        NavigationBar.mergedProps = JSON.parse(JSON.stringify(lastEntry));
      } else {
        // Reset current props when the stack is empty.
        NavigationBar.mergedProps = null;
      }
    });
  }

  //颜色取值逻辑
  getBarColorByType (): string {

    if(this.barStyle == 'light-content'){
      this.barStyle =  '#ffffffff';
    }else if(this.barStyle == 'dark-content'){
      this.barStyle =  '#ff000000';
    }

    return  this.barStyle;
  }

  //修改导航栏颜色
  private static  upNavigationBar () {
    window.getLastWindow(getContext(NavigationBar.target), (err, w) => {
      w.setWindowSystemBarProperties({
        // 导航栏颜色
        //   navigationBarColor:'#ff000000',
        // 导航栏文字颜色
        navigationBarContentColor: NavigationBar.target.getBarColorByType(),
      })
    })
  }

  aboutToAppear() {
    this.stackEntry = NavigationBar.pushStackEntry({barStyle: this.barStyle});
    //处理静态方法获取不到this问题
    NavigationBar.target = this;
  }

  private stackEntry: NavigationBarProps | null = null;

  navigationBarStyleUpdateCallback(){
    if (this.stackEntry) {
      this.stackEntry = NavigationBar.replaceStackEntry(
        this.stackEntry,
        {barStyle: this.barStyle},
      );
    }
  }

  aboutToDisappear(){
    //销毁
    if (this.stackEntry) {
      NavigationBar.popStackEntry(this.stackEntry);
    }
  }

  build() {}
}