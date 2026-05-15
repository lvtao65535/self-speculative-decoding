# Self-Speculative Decoding - 环境配置指南 (基于 uv)

根据当前设备的硬件情况（双卡 A100 80GB）和 CUDA 版本（12.2），我们移除了原项目中容易导致编译崩溃的老旧 `flash-attn`，放弃了笨重的 `conda`，全面转向 `uv` 以提升环境隔离的洁净度与构建速度。

以下是完整的安装与配置步骤：

## 1. 安装环境

请在项目根目录 `/data/lvtao/codes_new/self-speculative-decoding` 下顺序执行以下命令：

```bash
# 1. 创建并激活虚拟环境 (推荐使用 Python 3.10+)
uv venv --python 3.10
source .venv/bin/activate

# 2. 针对 CUDA 12.x 安装现代版本的 PyTorch
uv pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu121

# 3. 安装严格锁定的核心依赖 (特别是 transformers==4.33.1，不可更改)
uv pip install transformers==4.33.1

# 4. 安装数据集、优化算法库及其他评测辅助包
uv pip install datasets bayesian-optimization rouge-score numpy tqdm

# 5. 安装代码生成评测所需的 human-eval
uv pip install human-eval

# 6. 安装 ipykernel 以便在 VS Code 中执行 Jupyter Notebook 脚本
uv pip install ipykernel
python -m ipykernel install --user --name=ssd-env --display-name "Python (ssd-env)"
```

## 2. 后续运行注意事项

- **Jupyter Kernel 选择**: 在 VS Code 中打开 `search.ipynb` 或 `evaluate_*.ipynb` 时，请务必在右上角将 Kernel 切换为您刚安装的 **`Python (ssd-env)`**。
- **权重路径修改**: 原有的 Jupyter Notebook 脚本中，模型权重路径是硬编码的（如 `../llama-2-13b/`），在正式运行搜层或评估之前，请将其修改为您本地实际存放 LLaMA-2 权重的绝对路径。
- **CUDA 显卡分配**: 如果您计划评估 70B 模型，原代码中硬编码的 `.to('cuda:0')` 单卡加载方式将会导致 A100 80GB OOM。您需要将其改为 `device_map="auto"`，以利用双卡显存（160GB总计）进行张量并行。对于 13B 模型，单卡即可正常跑通。