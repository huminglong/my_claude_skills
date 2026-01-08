#!/bin/bash
set -e

# 将 .drawio 文件转换为 .drawio.png
generated_files=()

for drawio in "$@"; do
  png="${drawio%.drawio}.drawio.png"
  echo "正在转换 $drawio 到 $png..."

  # drawio CLI 以 2 倍缩放导出 PNG 以获得高质量
  if ! drawio -x -f png -s 2 -t -o "$png" "$drawio" 2>/dev/null; then
    echo "✗ $drawio 的 drawio PNG 导出失败" >&2
    continue
  fi

  generated_files+=("$png")
  echo "✓ 已生成 $png"
done

# 一次性暂存所有生成的文件以避免 index.lock 冲突
if [ ${#generated_files[@]} -gt 0 ]; then
  git add "${generated_files[@]}"
  echo "已暂存 ${#generated_files[@]} 个文件"
fi
