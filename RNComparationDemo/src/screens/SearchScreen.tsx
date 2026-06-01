import { useState } from "react";
import {
  FlatList,
  Pressable,
  StyleSheet,
  Text,
  TextInput,
  View,
} from "react-native";
import { SafeAreaView } from "react-native-safe-area-context";
import BackButton from "../components/BackButton";
import GameCard from "../components/GameCard";
import Loader from "../components/Loader";
import useSearch from "../hooks/useSearch";
import { colors, spacing } from "../theme";

const SearchScreen = () => {
  const [input, setInput] = useState("");
  const [searchTerm, setSearchTerm] = useState("");
  const { data, isFetching, error, isFetched } = useSearch(searchTerm);

  const handleSearch = () => {
    const trimmed = input.trim();
    if (trimmed.length > 0) {
      setSearchTerm(trimmed);
    }
  };

  const results = data?.results ?? [];

  return (
    <SafeAreaView style={styles.container} edges={["top", "bottom"]}>
      <View style={styles.content}>
        <BackButton />

        <View style={styles.inputContainer}>
          <TextInput
            placeholder="Search games..."
            placeholderTextColor="#888"
            style={styles.input}
            value={input}
            onChangeText={setInput}
            onSubmitEditing={handleSearch}
            returnKeyType="search"
          />
          <Pressable style={styles.button} onPress={handleSearch}>
            <Text style={styles.buttonText}>Buscar</Text>
          </Pressable>
        </View>

        {isFetching && <Loader />}
        {error && <Text style={styles.error}>{error.message}</Text>}
        {data?.durationMs !== undefined && !isFetching && (
          <Text style={styles.apiTiming}>API: {data.durationMs} ms</Text>
        )}
        {isFetched && !isFetching && results.length === 0 && (
          <Text style={styles.emptyText}>No se encontraron juegos.</Text>
        )}

        <FlatList
          style={styles.list}
          data={results}
          key={`search-results-${searchTerm}`}
          keyExtractor={(item, index) =>
            String(item.game?.id ?? item.id ?? `result-${index}`)
          }
          numColumns={2}
          columnWrapperStyle={styles.row}
          contentContainerStyle={styles.listContent}
          showsVerticalScrollIndicator={false}
          removeClippedSubviews={false}
          keyboardShouldPersistTaps="handled"
          renderItem={({ item }) => (
            <View style={styles.cardWrapper}>
              <GameCard
                id={String(item.game?.id ?? item.id)}
                name={item.game.name}
                cover={item.game.cover}
              />
            </View>
          )}
        />
      </View>
    </SafeAreaView>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: colors.background,
  },
  content: {
    flex: 1,
    paddingHorizontal: spacing.lg,
    gap: spacing.lg,
  },
  inputContainer: {
    flexDirection: "row",
    alignItems: "center",
    backgroundColor: colors.white,
    paddingLeft: spacing.md,
    paddingRight: spacing.xs,
    paddingVertical: spacing.xs,
    borderWidth: 1,
    borderColor: colors.black,
    borderRadius: 50,
  },
  input: {
    flex: 1,
    color: colors.black,
    fontSize: 16,
    paddingVertical: spacing.sm,
  },
  button: {
    paddingVertical: spacing.md,
    paddingHorizontal: spacing.lg,
    borderRadius: 100,
    backgroundColor: colors.accent,
  },
  buttonText: {
    fontWeight: "600",
  },
  error: {
    color: "#c0392b",
  },
  apiTiming: {
    fontSize: 12,
    color: colors.textSecondary,
  },
  emptyText: {
    fontSize: 14,
    color: colors.textSecondary,
    fontStyle: "italic",
  },
  list: {
    flex: 1,
  },
  listContent: {
    paddingBottom: spacing.lg,
  },
  row: {
    justifyContent: "space-between",
    marginBottom: spacing.md,
  },
  cardWrapper: {
    width: "48%",
    alignItems: "center",
  },
});

export default SearchScreen;
