#!/bin/bash

# 貌似镜像和代理不能同时开？
export HF_ENDPOINT=https://hf-mirror.com

DATASET_DIR="/data/lvtao/hf_datasets"
MODEL_DIR="/data/lvtao/hf_models"

# ==================== 下载模型权重 ====================
# echo ">>> 开始下载 Llama-2-7b-hf（社区版: NousResearch/Llama-2-7b-hf） ..."
# huggingface-cli download NousResearch/Llama-2-7b-hf \
#     --local-dir "${MODEL_DIR}/llama-2-7b-hf" \
#     --resume-download

# echo ">>> 开始下载 Llama-2-13b-hf ..."
# huggingface-cli download meta-llama/Llama-2-13b-hf \
#     --local-dir "$BASE_DIR/llama-2-13b-hf" \
#     --resume-download

# echo ">>> 开始下载 Llama-2-70b-hf ..."
# huggingface-cli download meta-llama/Llama-2-70b-hf \
#     --local-dir "$BASE_DIR/llama-2-70b-hf" \
#     --resume-download

# echo ">>> 开始下载 CodeLlama-13b-hf ..."
# huggingface-cli download codellama/CodeLlama-13b-hf \
#     --local-dir "$BASE_DIR/codellama-13b-hf" \
#     --resume-download

# ==================== 下载数据集 ====================
echo ">>> 开始下载 xsum 数据集 ..."
huggingface-cli download --repo-type dataset xsum \
    --local-dir "${DATASET_DIR}/xsum" \
    --resume-download

echo ">>> 开始下载 cnn_dailymail 数据集 ..."
huggingface-cli download --repo-type dataset cnn_dailymail \
    --local-dir "${DATASET_DIR}/cnn_dailymail" \
    --resume-download

echo "==========================================="