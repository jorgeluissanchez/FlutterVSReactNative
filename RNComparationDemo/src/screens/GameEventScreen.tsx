import { ScrollView, StyleSheet, Text } from "react-native";
import { SafeAreaView } from "react-native-safe-area-context";
import type { NativeStackScreenProps } from "@react-navigation/native-stack";
import BackButton from "../components/BackButton";
import DateItem from "../components/DateItem";
import GameList from "../components/GameList";
import Loader from "../components/Loader";
import RemoteImage from "../components/RemoteImage";
import useGameEvent from "../hooks/useGameEvent";
import type { RootStackParamList } from "../types";
import { colors, spacing } from "../theme";

type Props = NativeStackScreenProps<RootStackParamList, "GameEvent">;

const GameEventScreen = ({ route }: Props) => {
  const { id } = route.params;
  const { data, isPending, error } = useGameEvent(id);

  if (isPending) return <Loader />;
  if (error) return <Text style={styles.error}>Error</Text>;

  const event = data!.event;
  const { name, description, start_time, event_logo, games } = event;

  const formattedDate = new Date(Number(start_time) * 1000).toLocaleDateString(
    "en-US",
    {
      day: "numeric",
      month: "short",
      year: "numeric",
    },
  );

  return (
    <SafeAreaView style={styles.container} edges={["top", "bottom"]}>
      <ScrollView
        contentContainerStyle={styles.content}
        showsVerticalScrollIndicator={false}
        removeClippedSubviews={false}
      >
        <BackButton />

        {data?.durationMs !== undefined && (
          <Text style={styles.apiTiming}>API: {data.durationMs} ms</Text>
        )}

        <RemoteImage
          imageId={event_logo?.image_id}
          recyclingKey={`event-detail-${id}-${event_logo?.image_id ?? "no-logo"}`}
          style={styles.logo}
        />

        <Text style={styles.title} numberOfLines={2}>
          {name}
        </Text>

        <DateItem date={formattedDate} />

        {description ? (
          <Text style={styles.description}>{description}</Text>
        ) : null}

        <GameList games={games ?? []} />
      </ScrollView>
    </SafeAreaView>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: colors.background,
  },
  content: {
    padding: spacing.lg,
    gap: spacing.lg,
  },
  error: {
    padding: spacing.lg,
  },
  apiTiming: {
    fontSize: 12,
    color: colors.textSecondary,
    alignSelf: "flex-end",
  },
  logo: {
    width: "100%",
    aspectRatio: 16 / 9,
    borderRadius: 10,
    borderWidth: 1,
    borderColor: colors.black,
  },
  title: {
    fontSize: 25,
    fontWeight: "600",
  },
  description: {
    fontSize: 16,
    lineHeight: 24,
  },
});

export default GameEventScreen;
