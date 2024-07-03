import {Platform} from 'react-native'
import {NavigationBar,SystemBars, StatusBar as Sb } from 'react-native-bars'
export * from "./types";
import Stb from './StatusBar'
const StatusBar = Platform.OS === "harmony" as string ? Stb : Sb;
export {
    NavigationBar,
    SystemBars,
    StatusBar
}