import { Pressable, StyleSheet, Text } from "react-native";
import { useNavigation } from "@react-navigation/native";
import type { NativeStackNavigationProp } from "@react-navigation/native-stack";
import type { IGamePreview, RootStackParamList } from "../types";
import RemoteImage from "./RemoteImage";
import { colors, spacing } from "../theme";

type NavigationProp = NativeStackNavigationProp<RootStackParamList>;

const GameCard = ({ id, name, cover }: IGamePreview) => {
  const navigation = useNavigation<NavigationProp>();

  return (
    <Pressable
      style={({ pressed }) => [styles.card, pressed && styles.cardPressed]}
      onPress={() => navigation.navigate("GameDetails", { id })}
    >
      <RemoteImage
        imageId={cover?.image_id}
        recyclingKey={`game-${id}-${cover?.image_id ?? "no-cover"}`}
        style={styles.image}
      />
      <Text style={styles.title} numberOfLines={2}>
        {name}
      </Text>
    </Pressable>
  );
};

const styles = StyleSheet.create({
  card: {
    width: 150,
    flexDirection: "column",
    padding: spacing.md,
    backgroundColor: colors.white,
    borderWidth: 1,
    borderColor: colors.black,
    borderRadius: 10,
    gap: spacing.sm,
  },
  cardPressed: {
    backgroundColor: colors.accent,
  },
  image: {
    width: "100%",
    aspectRatio: 3 / 4,
    borderRadius: 10,
    borderWidth: 1,
    borderColor: colors.black,
  },
  title: {
    fontWeight: "600",
  },
});

export default GameCard;
