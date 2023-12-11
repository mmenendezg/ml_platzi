import openai
import requests
import os

OPENAI_KEY = os.environ["OPENAI_KEY"]
MODEL_NAME = "ft:davinci-002:personal::8Sy2hIid"
STOP = " END"


def get_openai_response(prompt):
    client = openai.OpenAI(api_key=OPENAI_KEY)
    try:
        response = client.completions.create(
            model=MODEL_NAME, prompt=prompt, max_tokens=150, n=1, stop=STOP, temperature=0.5
        )
    except Exception as e:
        print(f"Error: {e}")
        
    return response.choices[0].text.strip()
