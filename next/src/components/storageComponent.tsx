"use client";

import ItemDisplayComponent from "@/components/itemDisplayComponent";
import { Store } from "@/types/storage";

type Props = {
  storage: Store;
};

export default function StorageComponent({ storage }: Props) {
  return (
    <div className="container grid grid-cols-9 gap-2 p-3 overflow-y-auto border">
      {storage.map((item, index) => (
        <ItemDisplayComponent item={item} key={index} />
      ))}
    </div>
  );
}
