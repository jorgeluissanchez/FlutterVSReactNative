import { ScrollView, StyleSheet } from "react-native";
import type { IGamePreview } from "../types";
import GameCard from "./GameCard";
import { spacing } from "../theme";

interface GameListProps {
  games: IGamePreview[];
}

const GameList = ({ games }: GameListProps) => (
  <ScrollView
    horizontal
    showsHorizontalScrollIndicator={false}
    removeClippedSubviews={false}
    contentContainerStyle={styles.list}
  >
    {games?.map((game) => (
      <GameCard key={`game-${game.id}`} {...game} />
    ))}
  </ScrollView>
);

const styles = StyleSheet.create({
  list: {
    gap: spacing.md,
    paddingRight: spacing.md,
  },
});

export default GameList;
