import { ActivityIndicator, StyleSheet, View } from "react-native";
import { colors } from "../theme";

const Loader = () => (
  <View style={styles.container}>
    <ActivityIndicator size="large" color={colors.accent} />
  </View>
);

const styles = StyleSheet.create({
  container: {
    paddingVertical: 24,
    alignItems: "center",
    justifyContent: "center",
  },
});

export default Loader;
