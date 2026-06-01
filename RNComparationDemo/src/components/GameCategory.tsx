import { StyleSheet, Text, View } from "react-native";
import useGameQuery from "../hooks/useGameQuery";
import GameList from "./GameList";
import Loader from "./Loader";
import { spacing } from "../theme";

interface GameCategoryProps {
  id: string;
  title: string;
  query: string;
}

const GameCategory = ({ id, title, query }: GameCategoryProps) => {
  const { data, isPending, error } = useGameQuery(query);

  if (isPending) return <Loader />;
  if (error) return <Text>Error: {error.message}</Text>;

  return (
    <View style={styles.category}>
      <Text style={styles.heading}>{title}</Text>
      <GameList games={data?.games ?? []} />
    </View>
  );
};

const styles = StyleSheet.create({
  category: {
    gap: spacing.lg,
    paddingLeft: spacing.lg,
  },
  heading: {
    fontSize: 18,
    fontWeight: "600",
  },
});

export default GameCategory;
