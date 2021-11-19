import { NativeModules } from 'react-native';

export const makeTabBarSnapshot = (backgroundColor) => NativeModules.RNTabBarSnapshot.makeTabBarSnapshot(backgroundColor);
