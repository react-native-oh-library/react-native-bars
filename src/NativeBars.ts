import type { TurboModule } from 'react-native/Libraries/TurboModule/RCTExport';
import { TurboModuleRegistry } from 'react-native';

export interface Spec extends TurboModule {
    setStatusBar: () => void;
    setNavigationBar: () => void;
} 
 
export default TurboModuleRegistry.get<Spec>('BarsNativeModule') as Spec | null;