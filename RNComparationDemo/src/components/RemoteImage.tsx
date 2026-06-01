import { Image, type ImageStyle } from "expo-image";
import { StyleSheet, View, type StyleProp } from "react-native";
import { getImageUrl } from "../utils";
import { colors } from "../theme";

interface RemoteImageProps {
  imageId?: string | null;
  style?: StyleProp<ImageStyle>;
  recyclingKey?: string;
}

const RemoteImage = ({ imageId, style, recyclingKey }: RemoteImageProps) => {
  if (!imageId) {
    return <View style={[style, styles.placeholder]} />;
  }

  const cacheKey = recyclingKey ?? imageId;

  return (
    <Image
      recyclingKey={cacheKey}
      source={{ uri: getImageUrl(imageId) }}
      style={style}
      contentFit="cover"
      cachePolicy="memory-disk"
    />
  );
};

const styles = StyleSheet.create({
  placeholder: {
    backgroundColor: "#ddd",
  },
});

export default RemoteImage;
