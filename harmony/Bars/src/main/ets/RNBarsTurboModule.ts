/*
 * Copyright (c) 2024 Huawei Device Co., Ltd. All rights reserved
 * Use of this source code is governed by a MIT license that can be
 * found in the LICENSE file.
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