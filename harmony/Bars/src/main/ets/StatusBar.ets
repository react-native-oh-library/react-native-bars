
/**
 * 状态栏状态修改组件
 */

import window from '@ohos.window';
import { StatusBarProps } from "./types";

function  createStackEntry(entry: StatusBarProps): StatusBarProps {
  if(!entry?.barStyle){
    entry.barStyle = 'light-content'
  }
  return entry;
}

@Component
export  struct StatusBar{
  //外界动态修改状态栏颜色实时监听
  @Prop @Watch("statusBarStyleUpdateCallback") barStyle: string = 'light-content';

  private static propsStack: StatusBarProps[] = [];
  private static timeOut: number | null = null;
  private static mergedProps: StatusBarProps | null = null;
  private static target: StatusBar;

  static pushStackEntry(props: StatusBarProps): StatusBarProps {
    const entry = createStackEntry(props);
    StatusBar.propsStack.push(entry);
    StatusBar.updatePropsStack();
    return entry;
  }

  static popStackEntry(entry: StatusBarProps): void {
    const index = StatusBar.propsStack.indexOf(entry);
    if (index !== -1) {
      StatusBar.propsStack.splice(index, 1);
    }
    StatusBar.updatePropsStack();
  }

  static replaceStackEntry(
    entry: StatusBarProps,
    props: StatusBarProps,
  ): StatusBarProps {
    const newEntry = createStackEntry(props);
    const index = StatusBar.propsStack.indexOf(entry);
    if (index !== -1) {
      StatusBar.propsStack[index] = newEntry;
    }
    StatusBar.updatePropsStack();
    return newEntry;
  }

  private static updatePropsStack() {
    // Send the update to the native module only once at the end of the frame.
    if (StatusBar.timeOut !== null) {
      clearTimeout(StatusBar.timeOut);
    }

    StatusBar.timeOut = setTimeout(() => {
      const oldProps = StatusBar.mergedProps;
      const lastEntry = StatusBar.propsStack[StatusBar.propsStack.length - 1];

      if (lastEntry != null) {
        // Update only if style have changed or if current props are unavailable.
        if (oldProps?.barStyle !== lastEntry.barStyle) {
          //todo
          StatusBar.upStatusBar();
        }
        // Update the current props values.
        StatusBar.mergedProps = JSON.parse(JSON.stringify(lastEntry));
      } else {
        // Reset current props when the stack is empty.
        StatusBar.mergedProps = null;
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

  //修改状态栏颜色
  private  static  upStatusBar () {
  window.getLastWindow(getContext(StatusBar.target), (err, w) => {
  w.setWindowSystemBarProperties({
  // 状态栏颜色
  //   statusBarColor: '#66666666',
  // 状态栏文字颜色
  statusBarContentColor: StatusBar.target.getBarColorByType(),
  })
  })
  }

  private stackEntry: StatusBarProps | null = null;


  aboutToAppear() {
    //初始化，执行修改状态栏内容颜色
    this.stackEntry = StatusBar.pushStackEntry({barStyle: this.barStyle});
    //处理静态方法获取不到this问题
    StatusBar.target = this;
  }

  aboutToDisappear(){
    //销毁
    if (this.stackEntry) {
      StatusBar.popStackEntry(this.stackEntry);
    }
  }

  statusBarStyleUpdateCallback(){
    //外界动态修改状态栏颜色实时修改
    if (this.stackEntry) {
      this.stackEntry = StatusBar.replaceStackEntry(
        this.stackEntry,
        {barStyle: this.barStyle},
      );
    }
  }


  build() {}
}
