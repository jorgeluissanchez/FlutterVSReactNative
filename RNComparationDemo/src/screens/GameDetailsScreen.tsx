import { useState } from "react";
import {
  Pressable,
  ScrollView,
  StyleSheet,
  Text,
  View,
} from "react-native";
import { SafeAreaView } from "react-native-safe-area-context";
import type { NativeStackScreenProps } from "@react-navigation/native-stack";
import BackButton from "../components/BackButton";
import DateItem from "../components/DateItem";
import GameList from "../components/GameList";
import Loader from "../components/Loader";
import CommentsSection from "../components/CommentsSection";
import RemoteImage from "../components/RemoteImage";
import useGame from "../hooks/useGame";
import type { RootStackParamList } from "../types";
import { colors, spacing } from "../theme";

type Props = NativeStackScreenProps<RootStackParamList, "GameDetails">;

const GameDetailsScreen = ({ route }: Props) => {
  const { id } = route.params;
  const [expanded, setExpanded] = useState(false);
  const { data, isPending, error } = useGame(id);

  if (isPending) return <Loader />;
  if (error) return <Text style={styles.error}>Error: {error.message}</Text>;

  const game = data!.game;
  const {
    name,
    cover,
    rating,
    release_dates,
    summary,
    genres,
    screenshots,
    platforms,
    involved_companies,
    similar_games,
  } = game;

  const summaryText = summary ?? "";
  const displaySummary =
    expanded || summaryText.length <= 200
      ? summaryText
      : `${summaryText.slice(0, 200)}...`;

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
        imageId={cover?.image_id}
        recyclingKey={`cover-${id}-${cover?.image_id ?? "no-cover"}`}
        style={styles.cover}
      />

      <View style={styles.gameInfo}>
        <Text style={styles.gameName}>{name}</Text>
        {rating ? (
          <View style={styles.ratingContainer}>
            <Text style={styles.ratingIcon}>⭐</Text>
            <Text style={styles.rating}>{(rating / 10).toFixed(1)}</Text>
          </View>
        ) : null}
      </View>

      <Text style={styles.developer}>
        By {involved_companies?.[0]?.company?.name ?? "Unknown"}
      </Text>
      <DateItem date={release_dates?.[0]?.human ?? "TBA"} />

      <Text style={styles.summary}>{displaySummary}</Text>
      {!expanded && summaryText.length > 200 && (
        <Pressable onPress={() => setExpanded(true)}>
          <Text style={styles.seeMore}>See More</Text>
        </Pressable>
      )}

      <View style={styles.tagContainer}>
        {genres?.map((genre) => (
          <Text key={genre.id} style={styles.tag}>
            {genre.name}
          </Text>
        ))}
      </View>

      <Text style={styles.heading}>Screenshots</Text>
      <ScrollView
        horizontal
        showsHorizontalScrollIndicator={false}
        removeClippedSubviews={false}
        contentContainerStyle={styles.horizontalList}
      >
        {screenshots?.map((screenshot) => (
          <RemoteImage
            key={`screenshot-${screenshot.id}`}
            imageId={screenshot.image_id}
            recyclingKey={`screenshot-${screenshot.id}-${screenshot.image_id}`}
            style={styles.screenshot}
          />
        ))}
      </ScrollView>

      <Text style={styles.heading}>You can play on</Text>
      <View style={styles.tagContainer}>
        {platforms?.map((platform) => (
          <Text key={platform.id} style={styles.tag}>
            {platform.name}
          </Text>
        ))}
      </View>

      <Text style={styles.heading}>You may also like</Text>
      <GameList games={similar_games ?? []} />

      <CommentsSection gameId={id} />
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
  cover: {
    width: "60%",
    aspectRatio: 3 / 4,
    alignSelf: "center",
    borderRadius: 10,
    borderWidth: 1,
    borderColor: colors.black,
  },
  gameInfo: {
    flexDirection: "row",
    alignItems: "center",
  },
  gameName: {
    fontSize: 25,
    fontWeight: "600",
    flex: 1,
  },
  ratingContainer: {
    flexDirection: "row",
    alignItems: "center",
    gap: spacing.sm,
  },
  ratingIcon: {
    fontSize: 20,
  },
  rating: {
    fontSize: 20,
    fontWeight: "600",
  },
  developer: {
    fontSize: 18,
    fontWeight: "500",
  },
  summary: {
    fontSize: 16,
    lineHeight: 24,
  },
  seeMore: {
    color: colors.accent,
    fontWeight: "600",
  },
  tagContainer: {
    flexDirection: "row",
    flexWrap: "wrap",
    gap: spacing.sm,
  },
  tag: {
    backgroundColor: colors.white,
    paddingVertical: spacing.xs,
    paddingHorizontal: spacing.sm,
    borderWidth: 1,
    borderColor: colors.black,
    borderRadius: 20,
  },
  heading: {
    fontSize: 18,
    fontWeight: "600",
  },
  horizontalList: {
    gap: spacing.md,
  },
  screenshot: {
    width: 230,
    aspectRatio: 16 / 9,
    borderRadius: 10,
    borderWidth: 1,
    borderColor: colors.black,
  },
});

export default GameDetailsScreen;
