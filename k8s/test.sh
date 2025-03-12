USER_PROMPT="I'm new to coding. If you could only recommend one programming language to start with, what would it be and why?"

curl -X POST http://localhost:8080/v1/chat/completions \
  -H "Content-Type: application/json" \
  -d @- <<EOF
{
    "prompt": "<start_of_turn>user\n${USER_PROMPT}<end_of_turn>\n",
    "temperature": 0.90,
    "top_p": 1.0,
    "max_tokens": 128
}
EOF


curl http://localhost:8080/v1/completions \
  -H "Content-Type: application/json" \
  -d '{
    "model": "google/gemma-2-2b-it",
    "prompt": "Tell me a three sentence bedtime story about a unicorn.",
    "max_tokens": 500,
    "temperature": 0
  }'

curl http://localhost:8080/v1/chat/completions \
  -H "Content-Type: application/json" \
  -d '{
    "model": "google/gemma-2-2b-it",
    "messages": [{"role": "user","content": "hello"},{"role": "assistant","content": "you are a helpful assistant!"},{"role": "user","content": "Tell me a three sentence bedtime story about a unicorn."}],
    "max_tokens": 500,
    "temperature": 0
  }'
