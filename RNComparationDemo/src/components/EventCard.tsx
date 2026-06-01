import { FlatList, Pressable, StyleSheet, Text, View } from "react-native";
import { useNavigation } from "@react-navigation/native";
import type { NativeStackNavigationProp } from "@react-navigation/native-stack";
import type { IGameEventPreview, RootStackParamList } from "../types";
import RemoteImage from "./RemoteImage";
import DateItem from "./DateItem";
import { colors, spacing } from "../theme";

type NavigationProp = NativeStackNavigationProp<RootStackParamList>;

const EventCard = ({ id, name, event_logo, start_time }: IGameEventPreview) => {
  const navigation = useNavigation<NavigationProp>();
  const isFutureDate = Number(start_time) > Math.floor(Date.now() / 1000);

  const formattedDate = new Date(Number(start_time) * 1000).toLocaleDateString(
    "en-US",
    {
      day: "numeric",
      month: "short",
      year: "numeric",
    },
  );

  return (
    <Pressable
      style={({ pressed }) => [styles.card, pressed && styles.cardPressed]}
      onPress={() => {
        if (!isFutureDate) {
          navigation.navigate("GameEvent", { id });
        }
      }}
    >
      <RemoteImage
        imageId={event_logo?.image_id}
        recyclingKey={`event-${id}-${event_logo?.image_id ?? "no-logo"}`}
        style={styles.image}
      />
      <Text style={styles.title} numberOfLines={2}>
        {name}
      </Text>
      <View style={styles.footer}>
        <DateItem date={formattedDate} />
        {isFutureDate && <Text style={styles.status}>Upcoming</Text>}
      </View>
    </Pressable>
  );
};

const styles = StyleSheet.create({
  card: {
    width: 300,
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
    aspectRatio: 16 / 9,
    borderRadius: 10,
    borderWidth: 1,
    borderColor: colors.black,
  },
  title: {
    fontWeight: "600",
  },
  footer: {
    flexDirection: "row",
    alignItems: "center",
    gap: spacing.sm,
  },
  status: {
    color: colors.accent,
    fontWeight: "600",
    fontSize: 13,
  },
});

export default EventCard;
