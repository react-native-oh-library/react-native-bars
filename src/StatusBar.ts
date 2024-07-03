import type { ViewProps } from "react-native/Libraries/Components/View/ViewPropTypes";
import type { HostComponent } from "react-native";
import codegenNativeComponent from "react-native/Libraries/Utilities/codegenNativeComponent";
export interface NativeProps extends ViewProps {
    barStyle?: string;
 // 添加其它 props
}
export default codegenNativeComponent<NativeProps>("StatusBar") as HostComponent<NativeProps>;