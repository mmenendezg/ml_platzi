from transformers import AutoTokenizer, AutoModelForCausalLM, pipeline
from langchain_community.llms.huggingface_pipeline import HuggingFacePipeline
import torch
import os

HF_TOKEN = os.getenv("HUGGINGFACE_TOKEN")
MODEL_PATH = "meta-llama/Llama-2-7b-hf"

def main():
    tokenizer = AutoTokenizer.from_pretrained(MODEL_PATH, token=HF_TOKEN)
    llama_model = AutoModelForCausalLM.from_pretrained(
        MODEL_PATH,
        offload_folder="../model",
        torch_dtype=torch.float16,
        token=HF_TOKEN,
        device_map="auto"
    )

    llama_pipeline = pipeline(
        model=llama_model,
        tokenizer=tokenizer,
        task="text-generation",
        max_new_tokens=50,
        repetition_penalty=1.1
    )

    input_text = "She is"
    output_text = llama_pipeline(input_text)
    print(output_text)


if __name__ == "__main__":
    main()
