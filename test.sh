resp=$(curl -X GET "http://127.0.0.1:6000/items/123?q=test" | jq .)

echo $resp