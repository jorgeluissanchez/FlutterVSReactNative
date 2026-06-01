import { StatusBar } from "expo-status-bar";
import { QueryClient, QueryClientProvider } from "@tanstack/react-query";
import { SafeAreaProvider } from "react-native-safe-area-context";
import AppNavigator from "./src/navigation/AppNavigator";
import { CommentsProvider } from "./src/context/CommentsContext";

const queryClient = new QueryClient();

export default function App() {
  return (
    <SafeAreaProvider>
      <QueryClientProvider client={queryClient}>
        <CommentsProvider>
          <AppNavigator />
          <StatusBar style="dark" />
        </CommentsProvider>
      </QueryClientProvider>
    </SafeAreaProvider>
  );
}
