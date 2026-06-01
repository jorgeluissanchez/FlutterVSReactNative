import { ScrollView, StyleSheet, Text, View } from "react-native";
import useGameEvents from "../hooks/useGameEvents";
import EventCard from "./EventCard";
import Loader from "./Loader";
import { spacing } from "../theme";

const GameEvents = () => {
  const { data, isPending, error } = useGameEvents();

  if (isPending) return <Loader />;
  if (error) return <Text>Error: {error.message}</Text>;

  return (
    <View style={styles.category}>
      <Text style={styles.heading}>Game Events</Text>
      <ScrollView
        horizontal
        showsHorizontalScrollIndicator={false}
        removeClippedSubviews={false}
        contentContainerStyle={styles.list}
      >
        {data?.events?.map((event) => (
          <EventCard key={`event-${event.id}`} {...event} />
        ))}
      </ScrollView>
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
  list: {
    gap: spacing.md,
    paddingRight: spacing.md,
  },
});

export default GameEvents;
