import { StyleSheet, Text, View } from "react-native";
import { colors, spacing } from "../theme";

interface DateItemProps {
  date: string;
}

const DateItem = ({ date }: DateItemProps) => (
  <View style={styles.container}>
    <Text style={styles.icon}>📅</Text>
    <Text style={styles.date}>{date}</Text>
  </View>
);

const styles = StyleSheet.create({
  container: {
    flexDirection: "row",
    alignItems: "center",
    gap: spacing.sm,
    borderWidth: 1,
    borderColor: colors.black,
    alignSelf: "flex-start",
    paddingVertical: spacing.xs,
    paddingHorizontal: spacing.sm,
    borderRadius: 20,
    backgroundColor: colors.accent,
  },
  icon: {
    fontSize: 18,
  },
  date: {
    fontSize: 13,
  },
});

export default DateItem;
