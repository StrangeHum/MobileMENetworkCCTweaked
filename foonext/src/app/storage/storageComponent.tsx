"use client";

import ItemComponent from "./itemComponent";
import { Store } from "./types";

const x = 9;
const y = 10;
const scale = 1;

type Props = {
  storage: Store;
};

export default function StorageComponent({ storage }: Props) {
  return (
    <div className="grid grid-cols-9 gap-2 p-3 overflow-y-auto border">
      {storage.map((item, index) => (
        <ItemComponent item={item} key={index} />
      ))}
    </div>
  );
}
