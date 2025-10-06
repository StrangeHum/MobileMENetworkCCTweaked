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
    <div>
      <h1>Инвентарь</h1>
      <ul>
        {storage.map((item, index) => (
          <ItemComponent item={item} key={index} />
        ))}
      </ul>
    </div>
  );
}
