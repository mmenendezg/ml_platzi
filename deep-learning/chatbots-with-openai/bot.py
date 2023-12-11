import time
import os

from openai_fns import get_openai_response
from telegram_fns import get_updates, send_messages


def main():
    print("Starting bot...")
    offset = 0

    while True:
        updates = get_updates(offset)
        if updates:
            for update in updates:
                offset = update["update_id"] + 1
                chat_id = update["message"]["chat"]["id"]
                user_message = update["message"]["text"]
                print(f"Received message: {user_message}")
                gpt_response = get_openai_response(user_message)
                send_messages(chat_id, gpt_response)
        else:
            time.sleep(1)


if __name__ == "__main__":
    main()
