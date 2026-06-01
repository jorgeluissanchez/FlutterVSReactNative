import { Pressable, StyleSheet, Text, View } from "react-native";
import { useNavigation } from "@react-navigation/native";
import type { NativeStackNavigationProp } from "@react-navigation/native-stack";
import type { RootStackParamList } from "../types";
import { colors, spacing } from "../theme";

type NavigationProp = NativeStackNavigationProp<RootStackParamList>;

const Header = () => {
  const navigation = useNavigation<NavigationProp>();

  return (
    <View style={styles.header}>
      <Text style={styles.logo}>GamesExplorer RN</Text>
      <Pressable onPress={() => navigation.navigate("Search")}>
        <Text style={styles.searchIcon}>🔍</Text>
      </Pressable>
    </View>
  );
};

const styles = StyleSheet.create({
  header: {
    flexDirection: "row",
    alignItems: "center",
    justifyContent: "space-between",
    paddingHorizontal: spacing.lg,
    paddingTop: spacing.lg,
  },
  logo: {
    fontSize: 20,
    fontWeight: "600",
  },
  searchIcon: {
    fontSize: 20,
  },
});

export default Header;
