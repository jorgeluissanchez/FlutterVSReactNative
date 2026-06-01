import { useQuery } from "@tanstack/react-query";
import { igdbHeaders } from "../constants/api";
import type { IGameEvent } from "../types";
import { measureFetch } from "../utils";

const useGameEvent = (id: string) => {
  const getGameEvent = async () => {
    const query = `
      fields id, name, description, event_logo.image_id, start_time, games.cover.image_id, games.name;
      where id=${id};
    `;

    const { data, durationMs } = await measureFetch<IGameEvent[]>(
      "https://api.igdb.com/v4/events",
      {
        method: "POST",
        headers: igdbHeaders,
        body: query,
      },
    );

    return { event: data[0], durationMs };
  };

  return useQuery({
    queryKey: ["gameEvent", id],
    queryFn: getGameEvent,
    refetchOnWindowFocus: false,
    refetchOnMount: false,
    staleTime: Infinity,
    enabled: !!id,
  });
};

export default useGameEvent;
