"use client";

import { useRef, useState } from "react";
import SearchBarComponent from "./storage/searchBar";
import StorageComponent from "./storage/storageComponent";
import { useUpdateStoreage } from "./storage/useStorageSystem";
import { Store } from "./storage/types";

export default function Home() {
  const storage = useUpdateStoreage();
  const [filteredStorage, setFilteredStorage] = useState<Store>();

  if (storage === undefined) {
    return <div>loading</div>;
  }

  return (
    <div className="font-sans flex justify-center">
      <main className="">
        <SearchBarComponent
          storage={storage}
          setFilteredStorage={setFilteredStorage}
        />
        <StorageComponent storage={filteredStorage ?? storage} />
        {filteredStorage
          ? "filteredStorage пустой"
          : "filteredStorage не пустой"}
      </main>
    </div>
  );
}
