resp=$(curl -sS -X POST "http://127.0.0.1:6000/user" \
  -H "Content-Type: application/json" \
  -d '{"username":"good"}' | jq .)

echo "$resp"
