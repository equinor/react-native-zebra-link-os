import * as React from 'react';

import { StyleSheet, View, Text } from 'react-native';
import RNZebraLinkOs from 'react-native-zebra-link-os';

export default function App() {
  //log RNZebraLinkOs to check if it's null
  console.log(RNZebraLinkOs);
  return (
    <View style={styles.container}>
      <Text>Check the console to see if RNZebraLinkOs is null</Text>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
  },
  box: {
    width: 60,
    height: 60,
    marginVertical: 20,
  },
});
