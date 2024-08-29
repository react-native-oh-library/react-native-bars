/**
 * MIT License
 *
 * Copyright (C) 2024 Huawei Device Co., Ltd.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

import { TurboModule, TurboModuleContext } from '@rnoh/react-native-openharmony/ts';
import { TM } from '@rnoh/react-native-openharmony/generated/ts';
import window from '@ohos.window';
import Logger from './Logger'

export class RNBarsTurboModule extends TurboModule implements TM.BarsNativeModule.Spec {
  isKeepScreenOn: boolean = true;
  unisKeepScreenOn: boolean = false;

  constructor(ctx) {
    super(ctx);
  }

  //颜色取值逻辑
  getBarColorByType (barStyle): string {
    if(barStyle == 'light-content'){
      barStyle =  '#ffffffff';
    }else if(barStyle == 'dark-content'){
      barStyle =  '#ff000000';
    }
    return  barStyle;
  }

  public setStatusBarStyle(barStyle): void {
    try {
      window.getLastWindow(getContext(this), (err, w) => {
        w.setWindowSystemBarProperties({
          // 状态栏颜色
          statusBarContentColor: this.getBarColorByType(barStyle),
        })
      })
    } catch (exception) {
      Logger.error(exception);
    }
  }

  public setNavigationBarStyle(barStyle): void {
    try {
      window.getLastWindow(getContext(this), (err, w) => {
        w.setWindowSystemBarProperties({
          // 导航栏颜色
          navigationBarContentColor: this.getBarColorByType(barStyle),
        })
      })
    } catch (exception) {
      Logger.error(exception);
    }
  }


}