import { get } from "http";
import { useEffect, useState } from "react";
import { Store } from "./types";
import { apis } from "../apis";

export const updateStorage = (callback: any) => {
  fetch(apis.update, {
    method: "GET", // или "GET", если сервер это поддерживает
    headers: {
      "Content-Type": "application/json",
    },
  })
    .then((res) => res.json())
    .then((data) => {
      console.log("Получены данные:", data);
      callback(data);
    })
    .catch((err) => console.error("Ошибка при загрузке:", err));
};

export const useUpdateStoreage = () => {
  const [items, setItems] = useState<Store>();

  useEffect(() => {
    updateStorage(setItems);
  }, []);
  return items;
};
