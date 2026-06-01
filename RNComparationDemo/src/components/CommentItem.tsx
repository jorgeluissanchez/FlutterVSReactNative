import { Alert, Pressable, StyleSheet, Text, View } from "react-native";
import { useNavigation } from "@react-navigation/native";
import type { NativeStackNavigationProp } from "@react-navigation/native-stack";
import type { IComment, RootStackParamList } from "../types";
import { useComments } from "../context/CommentsContext";
import { colors, spacing } from "../theme";

type NavigationProp = NativeStackNavigationProp<RootStackParamList>;

interface CommentItemProps {
  comment: IComment;
}

const CommentItem = ({ comment }: CommentItemProps) => {
  const navigation = useNavigation<NavigationProp>();
  const { deleteComment } = useComments();

  const handleDelete = () => {
    Alert.alert(
      "Eliminar comentario",
      "¿Seguro que deseas eliminar este comentario?",
      [
        { text: "Cancelar", style: "cancel" },
        {
          text: "Eliminar",
          style: "destructive",
          onPress: () => deleteComment(comment.id),
        },
      ],
    );
  };

  return (
    <View style={styles.container}>
      <View style={styles.header}>
        <Text style={styles.author}>{comment.author}</Text>
        <View style={styles.actions}>
          <Pressable
            onPress={() =>
              navigation.navigate("CommentForm", {
                gameId: comment.gameId,
                commentId: comment.id,
              })
            }
          >
            <Text style={styles.actionText}>Editar</Text>
          </Pressable>
          <Pressable onPress={handleDelete}>
            <Text style={[styles.actionText, styles.deleteText]}>Eliminar</Text>
          </Pressable>
        </View>
      </View>
      <Text style={styles.text}>{comment.text}</Text>
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    backgroundColor: colors.white,
    borderWidth: 1,
    borderColor: colors.black,
    borderRadius: 10,
    padding: spacing.md,
    gap: spacing.sm,
  },
  header: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
  },
  author: {
    fontWeight: "600",
    fontSize: 15,
  },
  actions: {
    flexDirection: "row",
    gap: spacing.sm,
  },
  actionText: {
    color: colors.accent,
    fontWeight: "600",
    fontSize: 13,
  },
  deleteText: {
    color: "#c0392b",
  },
  text: {
    fontSize: 15,
    lineHeight: 22,
  },
});

export default CommentItem;
