#!/bin/bash

# 定义目标文件夹路径（注意：路径中使用反斜杠）
TARGET_ARCHIVE="E:\\game\\saved"

# 定义日志文件路径
LOG_FILE="E:\\game\\saved\\backup_log.txt"

# 获取当前时间戳
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")

# 日志记录：脚本开始
echo "$TIMESTAMP - Git backup script started" >> "$LOG_FILE"

# 检查目标文件夹是否存在
if [ ! -d "$TARGET_ARCHIVE" ]; then
    echo "$TIMESTAMP - Target folder does not exist: $TARGET_ARCHIVE" >> "$LOG_FILE"
    echo "Error: Target folder does not exist. Exiting script."
    exit 1
fi

# 切换到目标文件夹
cd "$TARGET_ARCHIVE" || {
    echo "$TIMESTAMP - Failed to change directory to $TARGET_ARCHIVE" >> "$LOG_FILE"
    echo "Error: Failed to change directory. Exiting script."
    exit 1
}

# 添加更改到 Git
echo "$TIMESTAMP - Adding changes to Git repository" >> "$LOG_FILE"
git add . >> "$LOG_FILE" 2>&1

# 提交更改
echo "$TIMESTAMP - Committing changes to Git repository" >> "$LOG_FILE"
git commit -m "Backup: $TIMESTAMP" >> "$LOG_FILE" 2>&1

# 推送到远程仓库
echo "$TIMESTAMP - Pushing changes to remote repository" >> "$LOG_FILE"
git push >> "$LOG_FILE" 2>&1

# 检查 Git 操作是否成功
if [ $? -eq 0 ]; then
    echo "$TIMESTAMP - Successfully committed and pushed to GitHub" >> "$LOG_FILE"
else
    echo "$TIMESTAMP - Failed to commit or push to GitHub. Check log for details" >> "$LOG_FILE"
fi

# 日志记录：脚本结束
echo "$TIMESTAMP - Git backup script ended" >> "$LOG_FILE"