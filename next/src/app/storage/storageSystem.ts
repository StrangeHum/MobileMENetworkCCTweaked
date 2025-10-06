import { get } from "http";

const apis = {
  update: "http://192.168.0.105:8081/update",
};

export const foo = new Promise((resolve, reject) => {
  fetch(apis.update, {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify({}),
  })
    .then((response) => {
      reject(response);
    })
    .catch((error) => {
      console.error(error);
    });
});
