import { NativeModules, Platform } from 'react-native';

const LINKING_ERROR =
  `The package 'react-native-new-zebra' doesn't seem to be linked. Make sure: \n\n` +
  Platform.select({ ios: "- You have run 'pod install'\n", default: '' }) +
  '- You rebuilt the app after installing the package\n' +
  '- You are not using Expo Go\n';

const RNZebraLinkOs = NativeModules.RNZebraLinkOs
  ? NativeModules.RNZebraLinkOs
  : new Proxy(
      {},
      {
        get() {
          throw new Error(LINKING_ERROR);
        },
      }
    );
console.log(RNZebraLinkOs);

export default RNZebraLinkOs;
