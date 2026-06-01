import { Pressable, StyleSheet, Text, View } from "react-native";
import { useNavigation } from "@react-navigation/native";
import type { NativeStackNavigationProp } from "@react-navigation/native-stack";
import type { RootStackParamList } from "../types";
import { useComments } from "../context/CommentsContext";
import CommentItem from "./CommentItem";
import { colors, spacing } from "../theme";

type NavigationProp = NativeStackNavigationProp<RootStackParamList>;

interface CommentsSectionProps {
  gameId: string;
}

const CommentsSection = ({ gameId }: CommentsSectionProps) => {
  const navigation = useNavigation<NavigationProp>();
  const { getCommentsByGameId } = useComments();
  const comments = getCommentsByGameId(gameId);

  return (
    <View style={styles.container}>
      <View style={styles.header}>
        <Text style={styles.heading}>Comentarios (CRUD local)</Text>
        <Pressable
          style={styles.addButton}
          onPress={() => navigation.navigate("CommentForm", { gameId })}
        >
          <Text style={styles.addButtonText}>+ Nuevo</Text>
        </Pressable>
      </View>

      {comments.length === 0 ? (
        <Text style={styles.emptyText}>
          No hay comentarios. Crea uno para probar el CRUD en memoria.
        </Text>
      ) : (
        comments.map((comment) => (
          <CommentItem key={comment.id} comment={comment} />
        ))
      )}
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    gap: spacing.md,
  },
  header: {
    flexDirection: "row",
    alignItems: "center",
    justifyContent: "space-between",
  },
  heading: {
    fontSize: 18,
    fontWeight: "600",
    flex: 1,
  },
  addButton: {
    backgroundColor: colors.accent,
    paddingVertical: spacing.sm,
    paddingHorizontal: spacing.md,
    borderRadius: 20,
    borderWidth: 1,
    borderColor: colors.black,
  },
  addButtonText: {
    fontWeight: "600",
    fontSize: 13,
  },
  emptyText: {
    fontSize: 14,
    color: colors.textSecondary,
    fontStyle: "italic",
  },
});

export default CommentsSection;
