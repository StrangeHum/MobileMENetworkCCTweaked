import { url } from "../apis.ts";

export async function GET() {
  const res = await fetch(`${url}/update`);
  const data = await res.json();

  return Response.json(data);
}
