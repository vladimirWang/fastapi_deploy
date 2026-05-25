resp=$(curl -X GET "http://127.0.0.1:6000/users" | jq .)

echo $resp