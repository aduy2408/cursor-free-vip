#!/bin/bash

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# 检查并安装必要的依赖
check_dependencies() {
    echo -e "${YELLOW}Checking system dependencies...${NC}"
    
    # 检查是否为 Ubuntu/Debian
# check basic commands instead of distro
    for cmd in python3 pip3; do
        if ! command -v $cmd &>/dev/null; then
            echo -e "${RED}❌ Missing dependency: $cmd${NC}"
            echo -e "${YELLOW}Please install it manually (e.g. sudo pacman -S python-pip)${NC}"
            exit 1
        fi
    done
    echo -e "${GREEN}✅ All required dependencies found.${NC}"

}

# 创建并激活虚拟环境
setup_venv() {
    echo -e "${GREEN}Creating virtual environment...${NC}"
    python3 -m venv venv
    
    echo -e "${GREEN}Starting virtual environment...${NC}"
    . ./venv/bin/activate || source ./venv/bin/activate
}

# 安装依赖
install_dependencies() {
    echo -e "${GREEN}Installing dependencies...${NC}"
    python3 -m pip install --upgrade pip
    pip3 install -r requirements.txt
}

# 构建程序
build_program() {
    echo -e "${GREEN}Starting build...${NC}"
    python3 build.py
}

# 清理
cleanup() {
    echo -e "${GREEN}Cleaning virtual environment...${NC}"
    deactivate 2>/dev/null || true
    rm -rf venv
}

# 主程序
main() {
    # 检查依赖
    check_dependencies
    
    # 设置虚拟环境
    setup_venv
    
    # 安装依赖
    install_dependencies
    
    # 构建
    build_program
    
    # 清理
    cleanup
    
    echo -e "${GREEN}Completed!${NC}"
    echo "Press any key to exit..."
    # 使用兼容的方式读取输入
    if [ "$(uname)" = "Linux" ]; then
        read dummy
    else
        read -n 1
    fi
}

# 运行主程序
main 
