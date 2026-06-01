import { useQuery } from "@tanstack/react-query";
import { igdbHeaders } from "../constants/api";
import type { IGameEventPreview } from "../types";
import { measureFetch } from "../utils";

const useGameEvents = () => {
  const getGameEvents = async () => {
    const query = `
      fields id, name, event_logo.image_id, start_time;
      sort start_time desc;
      limit 10;
    `;

    const { data, durationMs } = await measureFetch<IGameEventPreview[]>(
      "https://api.igdb.com/v4/events",
      {
        method: "POST",
        headers: igdbHeaders,
        body: query,
      },
    );

    return { events: data, durationMs };
  };

  return useQuery({
    queryKey: ["gameEvents"],
    queryFn: getGameEvents,
    refetchOnWindowFocus: false,
    refetchOnMount: false,
    staleTime: Infinity,
  });
};

export default useGameEvents;
