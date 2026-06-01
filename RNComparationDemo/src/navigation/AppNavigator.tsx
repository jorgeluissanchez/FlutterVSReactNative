import { NavigationContainer } from "@react-navigation/native";
import { createNativeStackNavigator } from "@react-navigation/native-stack";
import type { RootStackParamList } from "../types";
import HomeScreen from "../screens/HomeScreen";
import GameDetailsScreen from "../screens/GameDetailsScreen";
import GameEventScreen from "../screens/GameEventScreen";
import SearchScreen from "../screens/SearchScreen";
import CommentFormScreen from "../screens/CommentFormScreen";
import { colors } from "../theme";

const Stack = createNativeStackNavigator<RootStackParamList>();

const AppNavigator = () => (
  <NavigationContainer>
    <Stack.Navigator
      screenOptions={{
        headerShown: false,
        contentStyle: { backgroundColor: colors.background },
      }}
    >
      <Stack.Screen name="Home" component={HomeScreen} />
      <Stack.Screen name="GameDetails" component={GameDetailsScreen} />
      <Stack.Screen name="GameEvent" component={GameEventScreen} />
      <Stack.Screen name="Search" component={SearchScreen} />
      <Stack.Screen name="CommentForm" component={CommentFormScreen} />
    </Stack.Navigator>
  </NavigationContainer>
);

export default AppNavigator;
