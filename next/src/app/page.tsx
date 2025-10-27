"use client";

import { useState } from "react";
import SearchBarComponent from "@/components/searchBarComponent";
import StorageComponent from "@/components/storageComponent";
import { useUpdateStoreage } from "@/lib/useStorageSystem";
import { Store } from "@/types/storage";

export default function Home() {
  const [storage, error] = useUpdateStoreage();
  const [filteredStorage, setFilteredStorage] = useState<Store>();

  if (storage === undefined) {
    return <div>loading</div>;
  }

  return (
    <div className="font-sans flex justify-center">
      <main className="container">
        <div className="flex">
          {filteredStorage
            ? "filteredStorage пустой"
            : "filteredStorage не пустой"}
          {error}
        </div>
        <SearchBarComponent
          storage={storage}
          setFilteredStorage={setFilteredStorage}
        />
        <StorageComponent storage={filteredStorage ?? storage} />
      </main>
    </div>
  );
}
