import { useEffect, useState } from "react";
import {
  Alert,
  Pressable,
  ScrollView,
  StyleSheet,
  Text,
  TextInput,
  View,
} from "react-native";
import type { NativeStackScreenProps } from "@react-navigation/native-stack";
import BackButton from "../components/BackButton";
import { useComments } from "../context/CommentsContext";
import type { RootStackParamList } from "../types";
import { colors, spacing } from "../theme";

type Props = NativeStackScreenProps<RootStackParamList, "CommentForm">;

const CommentFormScreen = ({ route, navigation }: Props) => {
  const { gameId, commentId } = route.params;
  const isEditing = !!commentId;
  const { getCommentById, createComment, updateComment } = useComments();

  const [author, setAuthor] = useState("");
  const [text, setText] = useState("");

  useEffect(() => {
    if (commentId) {
      const comment = getCommentById(commentId);
      if (comment) {
        setAuthor(comment.author);
        setText(comment.text);
      }
    }
  }, [commentId, getCommentById]);

  const handleSubmit = () => {
    const trimmedAuthor = author.trim();
    const trimmedText = text.trim();

    if (!trimmedAuthor || !trimmedText) {
      Alert.alert("Campos requeridos", "Autor y comentario son obligatorios.");
      return;
    }

    if (isEditing && commentId) {
      updateComment(commentId, trimmedAuthor, trimmedText);
    } else {
      createComment(gameId, trimmedAuthor, trimmedText);
    }

    navigation.goBack();
  };

  return (
    <ScrollView
      style={styles.container}
      contentContainerStyle={styles.content}
      keyboardShouldPersistTaps="handled"
    >
      <BackButton />

      <Text style={styles.title}>
        {isEditing ? "Editar comentario" : "Nuevo comentario"}
      </Text>
      <Text style={styles.subtitle}>
        Los comentarios se guardan solo en memoria (CRUD simulado).
      </Text>

      <View style={styles.field}>
        <Text style={styles.label}>Autor</Text>
        <TextInput
          style={styles.input}
          value={author}
          onChangeText={setAuthor}
          placeholder="Tu nombre"
          placeholderTextColor="#888"
        />
      </View>

      <View style={styles.field}>
        <Text style={styles.label}>Comentario</Text>
        <TextInput
          style={[styles.input, styles.textArea]}
          value={text}
          onChangeText={setText}
          placeholder="Escribe tu comentario..."
          placeholderTextColor="#888"
          multiline
          numberOfLines={5}
          textAlignVertical="top"
        />
      </View>

      <Pressable style={styles.submitButton} onPress={handleSubmit}>
        <Text style={styles.submitText}>
          {isEditing ? "Guardar cambios" : "Crear comentario"}
        </Text>
      </Pressable>
    </ScrollView>
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
  title: {
    fontSize: 22,
    fontWeight: "600",
  },
  subtitle: {
    fontSize: 14,
    color: colors.textSecondary,
  },
  field: {
    gap: spacing.sm,
  },
  label: {
    fontWeight: "600",
    fontSize: 15,
  },
  input: {
    backgroundColor: colors.white,
    borderWidth: 1,
    borderColor: colors.black,
    borderRadius: 10,
    padding: spacing.md,
    fontSize: 16,
  },
  textArea: {
    minHeight: 120,
  },
  submitButton: {
    backgroundColor: colors.accent,
    padding: spacing.md,
    borderRadius: 10,
    borderWidth: 1,
    borderColor: colors.black,
    alignItems: "center",
  },
  submitText: {
    fontWeight: "600",
    fontSize: 16,
  },
});

export default CommentFormScreen;
