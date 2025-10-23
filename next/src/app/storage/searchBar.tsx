"use client";

import {
  Dispatch,
  RefObject,
  SetStateAction,
  use,
  useEffect,
  useState,
} from "react";
import { Item, Store } from "./types";

type Props = {
  storage: Store;
  setFilteredStorage: Dispatch<SetStateAction<Store | undefined>>;
};

const escapeRegExp = (text: string) =>
  text.replace(/[.*+?^${}()|[\]\\]/g, "\\$&");

export default function SearchBarComponent({
  storage,
  setFilteredStorage,
}: Props) {
  const [searchText, setSearchText] = useState("");

  useEffect(() => {
    const regex = new RegExp(escapeRegExp(searchText), "i");
    const _store = storage.filter((item) => regex.test(item.displayName));

    // if (_store.length == 0) {
    //   return;
    // }

    setFilteredStorage(_store);
  }, [searchText, storage]);

  return (
    <div className="flex justify-center">
      <input
        className="bg-gray-500 rounded-4xl text-center"
        type="text"
        onChange={(text) => {
          setSearchText(text.target.value);
        }}
      />
    </div>
  );
}
