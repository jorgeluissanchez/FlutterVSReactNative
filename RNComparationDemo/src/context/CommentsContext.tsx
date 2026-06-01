import {
  createContext,
  useContext,
  useMemo,
  useReducer,
  type ReactNode,
} from "react";
import type { IComment } from "../types";

type CommentsState = {
  comments: IComment[];
};

type CommentsAction =
  | {
      type: "CREATE";
      payload: { gameId: string; author: string; text: string };
    }
  | {
      type: "UPDATE";
      payload: { id: string; author: string; text: string };
    }
  | { type: "DELETE"; payload: { id: string } };

type CommentsContextValue = {
  comments: IComment[];
  createComment: (gameId: string, author: string, text: string) => void;
  updateComment: (id: string, author: string, text: string) => void;
  deleteComment: (id: string) => void;
  getCommentsByGameId: (gameId: string) => IComment[];
  getCommentById: (id: string) => IComment | undefined;
};

const CommentsContext = createContext<CommentsContextValue | null>(null);

function createId() {
  return `${Date.now()}-${Math.random().toString(36).slice(2, 9)}`;
}

function commentsReducer(
  state: CommentsState,
  action: CommentsAction,
): CommentsState {
  switch (action.type) {
    case "CREATE":
      return {
        comments: [
          {
            id: createId(),
            gameId: action.payload.gameId,
            author: action.payload.author,
            text: action.payload.text,
            createdAt: Date.now(),
          },
          ...state.comments,
        ],
      };
    case "UPDATE":
      return {
        comments: state.comments.map((comment) =>
          comment.id === action.payload.id
            ? {
                ...comment,
                author: action.payload.author,
                text: action.payload.text,
                updatedAt: Date.now(),
              }
            : comment,
        ),
      };
    case "DELETE":
      return {
        comments: state.comments.filter(
          (comment) => comment.id !== action.payload.id,
        ),
      };
    default:
      return state;
  }
}

export function CommentsProvider({ children }: { children: ReactNode }) {
  const [state, dispatch] = useReducer(commentsReducer, { comments: [] });

  const value = useMemo<CommentsContextValue>(
    () => ({
      comments: state.comments,
      createComment: (gameId, author, text) =>
        dispatch({ type: "CREATE", payload: { gameId, author, text } }),
      updateComment: (id, author, text) =>
        dispatch({ type: "UPDATE", payload: { id, author, text } }),
      deleteComment: (id) => dispatch({ type: "DELETE", payload: { id } }),
      getCommentsByGameId: (gameId) =>
        state.comments.filter((comment) => comment.gameId === gameId),
      getCommentById: (id) =>
        state.comments.find((comment) => comment.id === id),
    }),
    [state.comments],
  );

  return (
    <CommentsContext.Provider value={value}>{children}</CommentsContext.Provider>
  );
}

export function useComments() {
  const context = useContext(CommentsContext);
  if (!context) {
    throw new Error("useComments must be used within CommentsProvider");
  }
  return context;
}
