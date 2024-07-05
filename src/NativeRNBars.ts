import type { TurboModule } from 'react-native/Libraries/TurboModule/RCTExport';
import { TurboModuleRegistry } from 'react-native';

export interface Spec extends TurboModule {
    setStatusBarStyle(style: string): void;
    setNavigationBarStyle(style: string): void;
} 
 
export default TurboModuleRegistry.get<Spec>('BarsNativeModule') as Spec | null;