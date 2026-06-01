import { Pressable, StyleSheet, Text } from "react-native";
import { useNavigation } from "@react-navigation/native";
import { colors, spacing } from "../theme";

const BackButton = () => {
  const navigation = useNavigation();

  return (
    <Pressable
      style={({ pressed }) => [
        styles.button,
        pressed && { backgroundColor: colors.accent },
      ]}
      onPress={() => navigation.goBack()}
    >
      <Text style={styles.icon}>←</Text>
    </Pressable>
  );
};

const styles = StyleSheet.create({
  button: {
    padding: spacing.sm,
    borderWidth: 1,
    borderColor: colors.black,
    alignSelf: "flex-start",
    borderRadius: 100,
    backgroundColor: colors.white,
  },
  icon: {
    fontSize: 18,
  },
});

export default BackButton;
