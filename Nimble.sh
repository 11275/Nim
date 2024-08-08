#!/bin/bash

function preface(){
    echo -e "\e[0;32m  【*******tom哥脚本适用前言*****************】\e[0m"
    echo -e "\e[0;32m  【*******本脚本创作初衷是为了让广大的不了解nim新手的更快的理解和挖上矿*****************】\e[0m"
    echo -e "\e[0;32m  【*******本脚本不盈任何的利益，没有任何采集相关信息的代码，代码开源放心使用*****************】\e[0m"
    echo -e "\e[0;32m  【*******这是我作为初学者用心创作出来的脚本，包含大量的提示和引导,请尊重我的劳动成果*****************】\e[0m"
    echo -e "\e[0;32m  【*******如果是纯小白，基础linux命令都不会的也不建议使用该脚本*****************】\e[0m"
    echo -e "\e[0;32m  【*******请认真的查看我相关的引导和提示，如果不习惯这种方式，请直接删除该脚本*****************】\e[0m"
    echo -e "\e[0;32m  【*******这是删除命令 rm -rf Nimble.sh*****************】\e[0m"
}

function root_model_ch(){
    # 检查是否以root用户运行脚本
    if [ "$(id -u)" != "0" ]; then
        echo -e "\e[0;31m此脚本需要以root用户权限运行。\e[0m"
        echo -e "\e[0;31m请尝试使用 'sudo -i' 命令切换到root用户，然后再次运行此脚本。\e[0m"
        exit 1
    fi
}

# 导入Socks5代理
function open_clash(){
    echo -e "\e[0;32m请输入HTTP代理地址 (格式为 host:port 参考 192.168.1.12:7899)\e[0m"
    read -p "请输入: " proxy
    export proxy
    export http_proxy=http://$proxy
    export https_proxy=http://$proxy
    echo -e "\e[0;32m已设置HTTP代理为: $proxy \e[0m"
}

function confirm_path(){
    echo -e "\e[0;32m本程序默认运行在/root目录下会生成nimable文件夹，请确认程序运行路径，如需修改请填写相关路径，如不需修改则直接回车进行\e[0m"
    read -p "请输入: " path
    export path
    if [ ! -z "$path" ]; then
        echo "路径设置为======$path============="
    else
        echo "不做修改，路径为/root/nimble"
    fi
    path=$path
}

function one_click_one_gpu(){
    confirm_path
    echo "INFO=========================path:$path"
    echo -e "\e[0;32m  【*******$allConfirm**********】\e[0m"
    echo -e "\e[0;32m  【*******tom哥温馨提醒该操作只限于用于新机器没有安装过NIM程序/或者想在不同路径重新安装**********】\e[0m"
    echo -e "\e[0;32m  【*******tom哥温馨提醒该操作仅限于单卡电脑**********】\e[0m"
    read -p "是否确认操作，确认输入 y: " confirm
    export confirm
    if [ $confirm =  y ]; then
        install_environments
        install_wallet
        install_nim
        create_wallet
        echo -e "\e[0;32m  【*******tom哥温馨提醒接下来将执行挖矿操作，请选择运行模式**********】\e[0m"
        echo -e "\e[0;32m  【*******新钱包运行模式输入  1**********】\e[0m"
        echo -e "\e[0;32m  【*******老钱包/已注册钱包运行模式输入  2**********】\e[0m"
        read -p "请输入（1或者2）: " model
        if [ "$model" -eq 1 ] || [ "$model" -eq 2 ] ;then
            if [ "$model" -eq 1 ] ;then
                start_with_new_one_gpu
            else
                start_with_old_one_gpu
            fi
        else
            back_main_menu
        fi
    fi
    back_main_menu
}

function one_click_gpus(){
    confirm_path
    echo "INFO=========================path:$path"
    echo -e "\e[0;32m  【*******$allConfirm**********】\e[0m"
    echo -e "\e[0;32m  【*******tom哥温馨提醒该操作只限于用于新机器没有安装过NIM程序/或者想在不同路径重新安装**********】\e[0m"
    echo -e "\e[0;32m  【*******tom哥温馨提醒该操作仅限于多卡机***********】\e[0m"
    read -p "是否确认操作，确认输入 y: " confirm
    export confirm
    if [ $confirm =  y ]; then
        install_environments
        install_wallet
        install_nim
        create_wallet
        echo -e "\e[0;32m  【*******tom哥温馨提醒接下来将执行挖矿操作，请选择运行模式**********】\e[0m"
        echo -e "\e[0;32m  【*******新钱包运行模式输入  1**********】\e[0m"
        echo -e "\e[0;32m  【*******老钱包/已注册钱包运行模式输入  2**********】\e[0m"
        read -p "请输入（1或者2）: " model
        if [ "$model" -eq 1 ] || [ "$model" -eq 2 ] ;then
            if [ "$model" -eq 1 ] ;then
                start_with_new_gpus
            else
                start_with_old_gpus
            fi
        else
            back_main_menu
        fi
    fi
    back_main_menu
}

function one_click_gpus_more(){
    confirm_path
    echo "INFO=========================path:$path"
    echo -e "\e[0;32m  【*******$allConfirm**********】\e[0m"
    echo -e "\e[0;32m  【*******tom哥温馨提醒该操作只限于用于新机器没有安装过NIM程序/或者想在不同路径重新安装**********】\e[0m"
    echo -e "\e[0;32m  【*******tom哥温馨提醒该操作仅限于多卡机***********】\e[0m"
    read -p "是否确认操作，确认输入 y: " confirm
    export confirm
    if [ $confirm =  y ]; then
        install_environments
        install_wallet
        install_nim
        create_wallet
        echo -e "\e[0;32m  【*******tom哥温馨提醒接下来将执行挖矿操作，请选择运行模式**********】\e[0m"
        echo -e "\e[0;32m  【*******新钱包运行模式输入  1**********】\e[0m"
        echo -e "\e[0;32m  【*******老钱包/已注册钱包运行模式输入  2**********】\e[0m"
        read -p "请输入（1或者2）: " model
        if [ "$model" -eq 1 ] || [ "$model" -eq 2 ] ;then
            if [ "$model" -eq 1 ] ;then
                start_with_new_gpus_more
            else
                start_with_old_gpus_more
            fi
        else
            back_main_menu
        fi
    fi
    back_main_menu
}



function install_environments(){
    #confirm_path
    #echo "INFO=========================path:$path"
    echo -e "\e[0;32m  【*******tom哥温馨提醒该操作只会安装基础依赖环境（python3.11和go）**********】\e[0m"
    echo -e "\e[0;32m  【*******tom哥温馨提醒要执行挖矿程序，必须要再安装矿机程序（即操作步骤 5）**********】\e[0m"
    if [ $allConfirm = n ];then
        install_environments_commond
    else
        read -p "是否确认操作，确认输入 y: " confirm
        export confirm
        if [ $confirm =  y ]; then
            install_environments_commond
            echo -e "\e[0;32m  【*******tom哥已帮您安装好了基础环境**********】\e[0m"
            echo -e "\e[0;31m  【*******tom哥提醒 如果出现报错信息 请自行解决安装依赖环境包  go---1.22.1  python----3.11**********】\e[0m"
        fi
        back_main_menu   
    fi
}

function install_environments_commond(){
    apt update
    apt install -y git nano python3-venv bison screen binutils gcc make bsdmainutils python3-pip build-essential

    cd $HOME
    mkdir -p ~/miniconda3
    wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh
    bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3
    rm -rf ~/miniconda3/miniconda.sh
    ~/miniconda3/bin/conda init bash
    source $HOME/.bashrc

    conda create -n nimble python=3.11 -y
    conda activate nimble

    # 安装GO
    rm -rf /usr/local/go
    wget https://go.dev/dl/go1.22.1.linux-amd64.tar.gz -P /tmp/
    tar -C /usr/local -xzf /tmp/go1.22.1.linux-amd64.tar.gz
    echo "export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin" >> ~/.bashrc
    export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin
    go version
}

function install_wallet(){
    if [ $allConfirm = y ];then
        confirm_path
    fi
    #echo "INFO=========================path:$path"
    if [ -z "$path" ]; then
        mkdir -p $HOME/nimble && cd $HOME/nimble
        git clone https://github.com/nimble-technology/wallet-public.git
        cd $HOME/nimble/wallet-public
        make install
    else
        mkdir -p $path/nimble && cd $path/nimble
        git clone https://github.com/nimble-technology/wallet-public.git
        cd $path/nimble/wallet-public
        make install
    fi
    echo -e "\e[0;32m  【*******tom哥已帮您安装好了钱包程序**********】\e[0m"
    if [ $allConfirm = y ];then
        back_main_menu
    fi
}

function install_nim(){
    if [ $allConfirm = y ];then
        confirm_path
    fi
    #echo "INFO=========================path:$path"
    if [ -z "$path" ]; then
        mkdir -p $HOME/nimble && cd $HOME/nimble
        git clone https://github.com/nimble-technology/nimble-miner-public.git
        cd $HOME/nimble/nimble-miner-public
        make install
    else
        mkdir -p $path/nimble && cd $path/nimble
        git clone https://github.com/nimble-technology/nimble-miner-public.git
        cd $path/nimble/nimble-miner-public
        make install
    fi
    echo -e "\e[0;32m  【*******tom哥已帮您安装好了挖矿程序**********】\e[0m"
    if [ $allConfirm = y ];then
        back_main_menu
    fi
}

function update_nim(){
    confirm_path
    echo "INFO=========================path:$path"
    if [ -z "$path" ]; then
        mkdir -p $HOME/nimble && cd $HOME/nimble/nimble-miner-public
    else
        mkdir -p $path/nimble && cd $path/nimble/nimble-miner-public
    fi
    git add .
    git stash
    git pull
    make install
    echo -e "\e[0;32m  【*******tom哥已帮您更新了挖矿程序**********】\e[0m"
    back_main_menu
}

function create_wallet(){
    if [ $allConfirm = y ];then
        confirm_path
    fi
    #echo "INFO=========================path:$path"
    if [ -z "$path" ]; then
        mkdir -p $HOME/nimble && cd $HOME/nimble/wallet-public
    else
        mkdir -p $path/nimble && cd $path/nimble/wallet-public
    fi
    echo "export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin" >> ~/.bashrc
    export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin
    make install
    echo -e "\e[0;32m  【*******tom哥温馨提醒**********】\e[0m"
    echo -e "\e[0;32m  【*******创建钱包至少要一对，主钱包和子钱包,多张卡需要生成nx2的倍数钱包 2 4  6 8**********】\e[0m"
    echo -e "\e[0;32m  【*******创建的新钱包必须等相关公告公开再注册使用，不然即使注册了也是无效钱包，无法进行正常挖矿**********】\e[0m"
    read -p "请输入你想要创建的钱包数量：" wallet_count
    for i in $(seq 1 $wallet_count); do
        wallet_name="wallet$i"
        nimble-networkd keys add $wallet_name --keyring-backend test
        echo -e "\e[0;32m  【*******钱包 $wallet_name 已创建**********】\e[0m"
    done    
    echo -e "\e[0;32m  【*******tom哥已帮您批量生成了钱包**********】\e[0m"
    echo -e "\e[0;31m  【*******请复制保存以上的相关信息（包含钱包地址和助记词），后期恢复钱包的唯一凭证**********】\e[0m"
    echo -e "\e[0;31m  【*******请复制保存以上的相关信息（包含钱包地址和助记词），后期恢复钱包的唯一凭证**********】\e[0m"
    echo -e "\e[0;31m  【*******请复制保存以上的相关信息（包含钱包地址和助记词），后期恢复钱包的唯一凭证**********】\e[0m"
    echo -e "\e[0;32m  【*******重要事情说三遍**********】\e[0m"
    read -p "请确认已经保存完毕,确认输入y：" confirm
    export confirm
    if [ $allConfirm = y ];then
        if [ $confirm =  y ]; then
            back_main_menu
        fi
    fi
}

function check_balance(){
    confirm_path
    echo "INFO=========================path:$path"
    if [ -z "$path" ]; then
        mkdir -p $HOME/nimble && cd $HOME/nimble/nimble-miner-public
    else
        mkdir -p $path/nimble && cd $path/nimble/nimble-miner-public
    fi
    make install
    echo -e "\e[0;32m  【*******tom哥温馨提醒**********】\e[0m"
    echo -e "\e[0;32m  【*******目前查询余额有俩种方式**********】\e[0m"
    echo -e "\e[0;32m  【*******第一种是网页端查询，输入主钱包地址，点击check balance即可**********】\e[0m"
    echo -e "\e[0;32m  【*******以下是网页地址**********】\e[0m"
    echo -e "\e[0;31m  【*******https://nimble.urlrevealer.com/**********】\e[0m"
    echo -e "\e[0;32m  【*******第二种是官方提供的查询方式，即本方式,注意成功上传一次记录之后才有可能更新余额**********】\e[0m"
    read -p "请输入挖矿主钱包地址: " master_wallet
    export master_wallet
    source ./nimenv_localminers/bin/activate
    make check addr=$master_wallet
    echo -e "\e[0;32m  【*******tom哥已帮您查询余额**********】\e[0m"
    back_main_menu
}

function view_upload(){
    confirm_path
    echo "INFO=========================path:$path"
    if [ -z "$path" ]; then
        mkdir -p $HOME/nimble && cd $HOME/nimble/nimble-miner-public
    else
        mkdir -p $path/nimble && cd $path/nimble/nimble-miner-public
    fi
    make install
    echo -e "\e[0;32m  【*******tom哥温馨提醒**********】\e[0m"
    echo -e "\e[0;32m  【*******查看的只是上传记录，并不是实际的余额，因当前余额更新模式不固定，所以请耐心等待**********】\e[0m"
    echo -e "\e[0;32m  【*******如果实在忍受不了，可以去官方dc开票去问**********】\e[0m"
    read -p "是否继续，确认输入y：" confirm
    export confirm
    if [ $confirm =  y ]; then
       source ./nimenv_localminers/bin/activate
       make logs
       echo -e "\e[0;32m  【*******tom哥已帮您查看当前上传记录**********】\e[0m"
    fi
    back_main_menu
}

function start_with_new_one_gpu(){
    echo -e "\e[0;32m  【*******tom哥温馨提醒**********】\e[0m"
    echo -e "\e[0;31m  【*******请确认当前钱包注册已开放**********】\e[0m"
    echo -e "\e[0;31m  【*******请确认当前钱包注册已开放**********】\e[0m"
    echo -e "\e[0;31m  【*******请确认当前钱包注册已开放**********】\e[0m"
    echo -e "\e[0;31m  【*******挖矿界面出现403，400 红色提示，不是报错，直接忽略**********】\e[0m"
    echo -e "\e[0;31m  【*******挖矿界面出现403，400 红色提示，不是报错，直接忽略**********】\e[0m"
    echo -e "\e[0;31m  【*******挖矿界面出现403，400 红色提示，不是报错，直接忽略**********】\e[0m"
    echo -e "\e[0;32m  【*******注册成功之后会返回 Mining power=10 ,此为初始信誉分  **********】\e[0m"
    echo -e "\e[0;31m  【*******注册失败一种情况会返回 Mining power=0**********】\e[0m"
    echo -e "\e[0;31m  【*******运行失败一种情况会返回 500 数值**********】\e[0m"
    read -p "确认是否继续操作，确认输入y：" confirm
    export confirm
    if [ $confirm =  y ]; then
        if [ $allConfirm = y ];then
            confirm_path
        fi
        echo "INFO=========================path:$path"
        if [ -z "$path" ]; then
            mkdir -p $HOME/nimble && cd $HOME/nimble/nimble-miner-public
        else
            mkdir -p $path/nimble && cd $path/nimble/nimble-miner-public
        fi
        source ./nimenv_localminers/bin/activate
        read -p "请输入需要注册的挖矿子钱包地址: " sub_wallet
        read -p "请输入需要注册的挖矿主钱包地址: " master_wallet
        export sub_wallet
        export master_wallet
        screen -dmS nim bash -c "make run addr=$sub_wallet master_wallet=$master_wallet"
        echo -e "\e[0;32m  【*******tom哥已帮您申请成功，如需查看当前挖矿状态请输入命令 'screen -r nim' 查看运行状态**********】\e[0m"
        back_main_menu
    fi
}

function start_with_old_one_gpu(){
    echo -e "\e[0;32m  【*******tom哥温馨提醒**********】\e[0m"
    echo -e "\e[0;31m  【*******挖矿界面出现403，400 红色提示，不是报错，直接忽略**********】\e[0m"
    echo -e "\e[0;31m  【*******挖矿界面出现403，400 红色提示，不是报错，直接忽略**********】\e[0m"
    echo -e "\e[0;31m  【*******挖矿界面出现403，400 红色提示，不是报错，直接忽略**********】\e[0m"
    echo -e "\e[0;32m  【*******运行成功之后会返回 Mining power大于10 ,该数值为信誉分  **********】\e[0m"
    echo -e "\e[0;31m  【*******运行失败一种情况会返回 Mining power=0**********】\e[0m"
    echo -e "\e[0;31m  【*******运行失败一种情况会返回 500 数值**********】\e[0m"
    echo -e "\e[0;31m  【*******运行失败一种情况会返回 Wallet  xxx  does not have master address 代表没有绑定主钱包**********】\e[0m"
    read -p "确认是否继续操作，确认输入y：" confirm
    export confirm
    if [ $confirm =  y ]; then
        if [ $allConfirm = y ];then
            confirm_path
        fi
        echo "INFO=========================path:$path"
        if [ -z "$path" ]; then
            mkdir -p $HOME/nimble && cd $HOME/nimble/nimble-miner-public
        else
            mkdir -p $path/nimble && cd $path/nimble/nimble-miner-public
        fi
        source ./nimenv_localminers/bin/activate
        read -p "请输入需要挖矿的子钱包地址: " sub_wallet
        export sub_wallet
        screen -dmS nim bash -c "make run addr=$sub_wallet"
        echo -e "\e[0;32m  【*******tom哥已帮您进行后台挖矿成功，如需查看当前挖矿状态请输入命令 'screen -r nim' 查看运行状态**********】\e[0m"
        back_main_menu
    fi
}

function show_status_one_gpu(){
    echo -e "\e[0;32m  【*******tom哥温馨提醒**********】\e[0m"
    echo -e "\e[0;31m  【*******稍后进入挖矿界面之后，键盘上按ctrl+a+d 进行无损退出操作**********】\e[0m"
    echo -e "\e[0;31m  【*******稍后进入挖矿界面之后，键盘上按ctrl+a+d 进行无损退出操作**********】\e[0m"
    echo -e "\e[0;31m  【*******稍后进入挖矿界面之后，键盘上按ctrl+a+d 进行无损退出操作**********】\e[0m"
    echo -e "\e[0;31m  【*******不要进行其他操作，打断挖矿，导致奖励丢失**********】\e[0m"
    read -p "是否确认知道如何操作，确认输入y：" confirm
    export confirm
    if [ $confirm =  y ]; then
        screen -r nim
    else
        back_main_menu
    fi
}

function close_node_one_gpu(){
    echo -e "\e[0;32m  【*******tom哥温馨提醒**********】\e[0m"
    echo -e "\e[0;31m  【*******此操作会关闭当前挖矿进程**********】\e[0m"
    echo -e "\e[0;31m  【*******此操作会关闭当前挖矿进程**********】\e[0m"
    echo -e "\e[0;31m  【*******此操作会关闭当前挖矿进程**********】\e[0m"
    read -p "是否确认继续操作，确认输入y：" confirm
    export confirm
    if [ $confirm =  y ]; then
        screen -X -S nim quit
        echo -e "\e[0;32m  【*******tom哥已帮您关闭当前挖矿进程**********】\e[0m"
        back_main_menu
    else
        back_main_menu
    fi
}

function start_with_new_gpus(){
    echo -e "\e[0;32m  【*******tom哥温馨提醒**********】\e[0m"
    echo -e "\e[0;31m  【*******请确认当前钱包注册已开放**********】\e[0m"
    echo -e "\e[0;31m  【*******请确认当前钱包注册已开放**********】\e[0m"
    echo -e "\e[0;31m  【*******请确认当前钱包注册已开放**********】\e[0m"
    echo -e "\e[0;31m  【*******挖矿界面出现403，400 红色提示，不是报错，直接忽略**********】\e[0m"
    echo -e "\e[0;31m  【*******挖矿界面出现403，400 红色提示，不是报错，直接忽略**********】\e[0m"
    echo -e "\e[0;31m  【*******挖矿界面出现403，400 红色提示，不是报错，直接忽略**********】\e[0m"
    echo -e "\e[0;32m  【*******注册成功之后会返回 Mining power=10 ,此为初始信誉分  **********】\e[0m"
    echo -e "\e[0;31m  【*******注册失败一种情况会返回 Mining power=0**********】\e[0m"
    echo -e "\e[0;31m  【*******运行失败一种情况会返回 500 数值**********】\e[0m"
    read -p "确认是否继续操作，确认输入y：" confirm
    export confirm
    if [ $confirm =  y ]; then
        if [ $allConfirm = y ];then
            confirm_path
        fi
        echo "INFO=========================path:$path"
        if [ -z "$path" ]; then
            mkdir -p $HOME/nimble && cd $HOME/nimble/nimble-miner-public
        else
            mkdir -p $path/nimble && cd $path/nimble/nimble-miner-public
        fi
        read -p "请输入目前本机插的卡数: " gpus_num
        export gpus_num
        for i in $(seq 1 $gpus_num); do
            read -p "请输入目前第$i张卡需要申请的子钱包地址: " sub_wallet
            read -p "请输入目前第$i张卡需要申请的主钱包地址: " master_wallet
            source ./nimenv_localminers/bin/activate
            (( x = $i-1))
            screen -dmS nim$i bash -c "CUDA_VISIBLE_DEVICES=$x make run addr=$sub_wallet master_wallet=$master_wallet"
            echo -e "\e[0;32m  【*******tom哥已帮您第$i张卡申请成功，已转为后台运行**********】\e[0m"
            echo -e "\e[0;32m  【*******请输入命令 'screen -r nim$i' 查看运行状态。**********】\e[0m"
        done
        echo -e "\e[0;32m  【*******tom哥已帮您批量操作成功**********】\e[0m"
        screen -ls
        echo -e "\e[0;32m  【*******tom哥为您提醒操作结果如上**********】\e[0m"
        back_main_menu
    fi    
}



function start_with_new_gpus_more(){
    echo -e "\e[0;32m  【*******tom哥温馨提醒**********】\e[0m"
    echo -e "\e[0;31m  【*******请确认当前钱包注册已开放**********】\e[0m"
    echo -e "\e[0;31m  【*******请确认当前钱包注册已开放**********】\e[0m"
    echo -e "\e[0;31m  【*******请确认当前钱包注册已开放**********】\e[0m"
    echo -e "\e[0;31m  【*******挖矿界面出现403，400 红色提示，不是报错，直接忽略**********】\e[0m"
    echo -e "\e[0;31m  【*******挖矿界面出现403，400 红色提示，不是报错，直接忽略**********】\e[0m"
    echo -e "\e[0;31m  【*******挖矿界面出现403，400 红色提示，不是报错，直接忽略**********】\e[0m"
    echo -e "\e[0;32m  【*******注册成功之后会返回 Mining power=10 ,此为初始信誉分  **********】\e[0m"
    echo -e "\e[0;31m  【*******注册失败一种情况会返回 Mining power=0**********】\e[0m"
    echo -e "\e[0;31m  【*******运行失败一种情况会返回 500 数值**********】\e[0m"
    read -p "确认是否继续操作，确认输入y：" confirm
    export confirm
    if [ $confirm =  y ]; then
        if [ $allConfirm = y ];then
            confirm_path
        fi
        echo "INFO=========================path:$path"
        if [ -z "$path" ]; then
            cd $HOME/nimble/
        else
            cd $path/nimble/
        fi
        read -p "请输入目前本机插的卡数: " gpus_num
        export gpus_num
        for i in $(seq 1 $gpus_num); do
            read -p "请输入目前第$i张卡需要申请的子钱包地址: " sub_wallet
            read -p "请输入目前第$i张卡需要申请的主钱包地址: " master_wallet
            DIRECTORY=nim_miner$i
            if [ -d "$DIRECTORY" ]; then
                echo "目录 $DIRECTORY 存在。"
            else
                echo "目录 $DIRECTORY 不存在。"
                cp -r nimble-miner-public  nim_miner$i
            fi
            cd nim_miner$i
            rm -rf my_model/
            make install
            source ./nimenv_localminers/bin/activate
            (( x = $i-1))
            screen -dmS nim$i bash -c "CUDA_VISIBLE_DEVICES=$x make run addr=$sub_wallet master_wallet=$master_wallet"
            echo -e "\e[0;32m  【*******tom哥已帮您第$i张卡申请成功，已转为后台运行**********】\e[0m"
            echo -e "\e[0;32m  【*******请输入命令 'screen -r nim$i' 查看运行状态。**********】\e[0m"
            cd ../
        done
        echo -e "\e[0;32m  【*******tom哥已帮您批量操作成功**********】\e[0m"
        screen -ls
        echo -e "\e[0;32m  【*******tom哥为您提醒操作结果如上**********】\e[0m"
        back_main_menu
    fi    
}




function start_with_old_gpus(){
    echo -e "\e[0;32m  【*******tom哥温馨提醒**********】\e[0m"
    echo -e "\e[0;31m  【*******挖矿界面出现403，400 红色提示，不是报错，直接忽略**********】\e[0m"
    echo -e "\e[0;31m  【*******挖矿界面出现403，400 红色提示，不是报错，直接忽略**********】\e[0m"
    echo -e "\e[0;31m  【*******挖矿界面出现403，400 红色提示，不是报错，直接忽略**********】\e[0m"
    echo -e "\e[0;32m  【*******运行成功之后会返回 Mining power大于10 ,该数值为信誉分  **********】\e[0m"
    echo -e "\e[0;31m  【*******运行失败一种情况会返回 Mining power=0**********】\e[0m"
    echo -e "\e[0;31m  【*******运行失败一种情况会返回 500 数值**********】\e[0m"
    echo -e "\e[0;31m  【*******运行失败一种情况会返回 Wallet  xxx  does not have master address 代表没有绑定主钱包**********】\e[0m"
    read -p "确认是否继续操作，确认输入y：" confirm
    export confirm
    if [ $confirm =  y ]; then
        if [ $allConfirm = y ];then
            confirm_path
        fi
        echo "INFO=========================path:$path"
        if [ -z "$path" ]; then
            mkdir -p $HOME/nimble && cd $HOME/nimble/nimble-miner-public
        else
            mkdir -p $path/nimble && cd $path/nimble/nimble-miner-public
        fi
        read -p "请输入目前本机插的卡数: " gpus_num
        export gpus_num
        for i in $(seq 1 $gpus_num); do
            read -p "请输入目前第$i张卡需要运行的子钱包地址: " sub_wallet
            source ./nimenv_localminers/bin/activate
            (( x = $i-1))
            screen -dmS nim$i bash -c "CUDA_VISIBLE_DEVICES=$x make run addr=$sub_wallet"
            echo -e "\e[0;32m  【*******tom哥已帮您第$i张卡后台运行成功**********】\e[0m"
            echo -e "\e[0;32m  【*******请输入命令 'screen -r nim$i' 查看运行状态。**********】\e[0m"
        done
        echo -e "\e[0;32m  【*******tom哥已帮您批量操作成功**********】\e[0m"
        screen -ls
        echo -e "\e[0;32m  【*******tom哥为您提醒操作结果如上**********】\e[0m"
        back_main_menu
    fi    
}

function start_with_old_gpus_more(){
    echo -e "\e[0;32m  【*******tom哥温馨提醒**********】\e[0m"
    echo -e "\e[0;31m  【*******挖矿界面出现403，400 红色提示，不是报错，直接忽略**********】\e[0m"
    echo -e "\e[0;31m  【*******挖矿界面出现403，400 红色提示，不是报错，直接忽略**********】\e[0m"
    echo -e "\e[0;31m  【*******挖矿界面出现403，400 红色提示，不是报错，直接忽略**********】\e[0m"
    echo -e "\e[0;32m  【*******运行成功之后会返回 Mining power大于10 ,该数值为信誉分  **********】\e[0m"
    echo -e "\e[0;31m  【*******运行失败一种情况会返回 Mining power=0**********】\e[0m"
    echo -e "\e[0;31m  【*******运行失败一种情况会返回 500 数值**********】\e[0m"
    echo -e "\e[0;31m  【*******运行失败一种情况会返回 Wallet  xxx  does not have master address 代表没有绑定主钱包**********】\e[0m"
    read -p "确认是否继续操作，确认输入y：" confirm
    export confirm
    if [ $confirm =  y ]; then
        if [ $allConfirm = y ];then
            confirm_path
        fi
        echo "INFO=========================path:$path"
        if [ -z "$path" ]; then
            cd $HOME/nimble
        else
            cd $path/nimble
        fi
        read -p "请输入目前本机插的卡数: " gpus_num
        export gpus_num
        for i in $(seq 1 $gpus_num); do
            read -p "请输入目前第$i张卡需要运行的子钱包地址: " sub_wallet
            DIRECTORY=nim_miner$i
            if [ -d "$DIRECTORY" ]; then
                echo "目录 $DIRECTORY 存在。"
            else
                echo "目录 $DIRECTORY 不存在。"
                cp -r nimble-miner-public  nim_miner$i
            fi
            cd nim_miner$i
            rm -rf my_model/
            make install
            source ./nimenv_localminers/bin/activate
            (( x = $i-1))
            screen -dmS nim$i bash -c "CUDA_VISIBLE_DEVICES=$x make run addr=$sub_wallet"
            echo -e "\e[0;32m  【*******tom哥已帮您第$i张卡后台运行成功**********】\e[0m"
            echo -e "\e[0;32m  【*******请输入命令 'screen -r nim$i' 查看运行状态。**********】\e[0m"
            cd ../
        done
        echo -e "\e[0;32m  【*******tom哥已帮您批量操作成功**********】\e[0m"
        screen -ls
        echo -e "\e[0;32m  【*******tom哥为您提醒操作结果如上**********】\e[0m"
        back_main_menu
    fi    
}



function start_with_new_gpus_appoint(){
    echo -e "\e[0;32m  【*******tom哥温馨提醒**********】\e[0m"
    echo -e "\e[0;31m  【*******请确认当前钱包注册已开放**********】\e[0m"
    echo -e "\e[0;31m  【*******请确认当前钱包注册已开放**********】\e[0m"
    echo -e "\e[0;31m  【*******请确认当前钱包注册已开放**********】\e[0m"
    echo -e "\e[0;31m  【*******挖矿界面出现403，400 红色提示，不是报错，直接忽略**********】\e[0m"
    echo -e "\e[0;31m  【*******挖矿界面出现403，400 红色提示，不是报错，直接忽略**********】\e[0m"
    echo -e "\e[0;31m  【*******挖矿界面出现403，400 红色提示，不是报错，直接忽略**********】\e[0m"
    echo -e "\e[0;32m  【*******注册成功之后会返回 Mining power=10 ,此为初始信誉分  **********】\e[0m"
    echo -e "\e[0;31m  【*******注册失败一种情况会返回 Mining power=0**********】\e[0m"
    echo -e "\e[0;31m  【*******运行失败一种情况会返回 500 数值**********】\e[0m"
    read -p "确认是否继续操作，确认输入y：" confirm
    export confirm
    if [ $confirm =  y ]; then
        if [ $allConfirm = y ];then
            confirm_path
        fi
        echo "INFO=========================path:$path"
        if [ -z "$path" ]; then
            mkdir -p $HOME/nimble && cd $HOME/nimble/nimble-miner-public
        else
            mkdir -p $path/nimble && cd $path/nimble/nimble-miner-public
        fi
        read -p "请输入需要运行的第几涨卡的序号（1，2，3，4..........）: " gpus_no
        export gpus_no
        read -p "请输入目前第$gpus_no张卡需要申请的子钱包地址: " sub_wallet
        read -p "请输入目前第$gpus_no张卡需要申请的主钱包地址: " master_wallet
        source ./nimenv_localminers/bin/activate
        (( x = $gpus_no-1))
        screen -dmS nim$gpus_no bash -c "CUDA_VISIBLE_DEVICES=$x make run addr=$sub_wallet master_wallet=$master_wallet"
        echo -e "\e[0;32m  【*******tom哥已帮您第$gpus_no张卡申请成功，已转为后台运行**********】\e[0m"
        echo -e "\e[0;32m  【*******请输入命令 'screen -r nim$gpus_no' 查看运行状态。**********】\e[0m"
        echo -e "\e[0;32m  【*******tom哥已帮您操作成功**********】\e[0m"
        screen -ls
        echo -e "\e[0;32m  【*******tom哥为您提醒操作结果如上**********】\e[0m"
        back_main_menu
    fi 
}


function start_with_new_gpus_appoint_more(){
    echo -e "\e[0;32m  【*******tom哥温馨提醒**********】\e[0m"
    echo -e "\e[0;31m  【*******请确认当前钱包注册已开放**********】\e[0m"
    echo -e "\e[0;31m  【*******请确认当前钱包注册已开放**********】\e[0m"
    echo -e "\e[0;31m  【*******请确认当前钱包注册已开放**********】\e[0m"
    echo -e "\e[0;31m  【*******挖矿界面出现403，400 红色提示，不是报错，直接忽略**********】\e[0m"
    echo -e "\e[0;31m  【*******挖矿界面出现403，400 红色提示，不是报错，直接忽略**********】\e[0m"
    echo -e "\e[0;31m  【*******挖矿界面出现403，400 红色提示，不是报错，直接忽略**********】\e[0m"
    echo -e "\e[0;32m  【*******注册成功之后会返回 Mining power=10 ,此为初始信誉分  **********】\e[0m"
    echo -e "\e[0;31m  【*******注册失败一种情况会返回 Mining power=0**********】\e[0m"
    echo -e "\e[0;31m  【*******运行失败一种情况会返回 500 数值**********】\e[0m"
    read -p "确认是否继续操作，确认输入y：" confirm
    export confirm
    if [ $confirm =  y ]; then
        if [ $allConfirm = y ];then
            confirm_path
        fi
        echo "INFO=========================path:$path"
        if [ -z "$path" ]; then
            cd $HOME/nimble
        else
            cd $path/nimble
        fi
        read -p "请输入需要运行的第几涨卡的序号（1，2，3，4..........）: " gpus_no
        export gpus_no
        read -p "请输入目前第$gpus_no张卡需要申请的子钱包地址: " sub_wallet
        read -p "请输入目前第$gpus_no张卡需要申请的主钱包地址: " master_wallet
        DIRECTORY=nim_miner$gpus_no
        if [ -d "$DIRECTORY" ]; then
            echo "目录 $DIRECTORY 存在。"
        else
            echo "目录 $DIRECTORY 不存在。"
            cp -r nimble-miner-public  nim_miner$gpus_no
        fi
        cd nim_miner$gpus_no
        rm -rf my_model/
        make install
        source ./nimenv_localminers/bin/activate
        (( x = $gpus_no-1))
        screen -dmS nim$gpus_no bash -c "CUDA_VISIBLE_DEVICES=$x make run addr=$sub_wallet master_wallet=$master_wallet"
        echo -e "\e[0;32m  【*******tom哥已帮您第$gpus_no张卡申请成功，已转为后台运行**********】\e[0m"
        echo -e "\e[0;32m  【*******请输入命令 'screen -r nim$gpus_no' 查看运行状态。**********】\e[0m"
        echo -e "\e[0;32m  【*******tom哥已帮您操作成功**********】\e[0m"
        screen -ls
        echo -e "\e[0;32m  【*******tom哥为您提醒操作结果如上**********】\e[0m"
        back_main_menu
    fi 
}



function start_with_old_gpus_appoint(){
    echo -e "\e[0;32m  【*******tom哥温馨提醒**********】\e[0m"
    echo -e "\e[0;31m  【*******挖矿界面出现403，400 红色提示，不是报错，直接忽略**********】\e[0m"
    echo -e "\e[0;31m  【*******挖矿界面出现403，400 红色提示，不是报错，直接忽略**********】\e[0m"
    echo -e "\e[0;31m  【*******挖矿界面出现403，400 红色提示，不是报错，直接忽略**********】\e[0m"
    echo -e "\e[0;32m  【*******运行成功之后会返回 Mining power大于10 ,该数值为信誉分  **********】\e[0m"
    echo -e "\e[0;31m  【*******运行失败一种情况会返回 Mining power=0**********】\e[0m"
    echo -e "\e[0;31m  【*******运行失败一种情况会返回 500 数值**********】\e[0m"
    echo -e "\e[0;31m  【*******运行失败一种情况会返回 Wallet  xxx  does not have master address 代表没有绑定主钱包**********】\e[0m"
    read -p "确认是否继续操作，确认输入y：" confirm
    export confirm
    if [ $confirm =  y ]; then
        if [ $allConfirm = y ];then
            confirm_path
        fi
        echo "INFO=========================path:$path"
        if [ -z "$path" ]; then
            mkdir -p $HOME/nimble && cd $HOME/nimble/nimble-miner-public
        else
            mkdir -p $path/nimble && cd $path/nimble/nimble-miner-public
        fi
        read -p "请输入需要运行的第几涨卡的序号（1，2，3，4..........）: " gpus_no
        export gpus_no
        read -p "请输入目前第$gpus_no张卡需要运行的子钱包地址: " sub_wallet
        source ./nimenv_localminers/bin/activate
        (( x = $gpus_no-1))
        screen -dmS nim$gpus_no bash -c "CUDA_VISIBLE_DEVICES=$x make run addr=$sub_wallet"
        echo -e "\e[0;32m  【*******tom哥已帮您第$gpus_no张卡后台运行成功**********】\e[0m"
        echo -e "\e[0;32m  【*******请输入命令 'screen -r nim$gpus_no' 查看运行状态。**********】\e[0m"
        echo -e "\e[0;32m  【*******tom哥已帮您操作成功**********】\e[0m"
        screen -ls
        echo -e "\e[0;32m  【*******tom哥为您提醒操作结果如上**********】\e[0m"
        back_main_menu
    fi 
}



function start_with_old_gpus_appoint_more(){
    echo -e "\e[0;32m  【*******tom哥温馨提醒**********】\e[0m"
    echo -e "\e[0;31m  【*******挖矿界面出现403，400 红色提示，不是报错，直接忽略**********】\e[0m"
    echo -e "\e[0;31m  【*******挖矿界面出现403，400 红色提示，不是报错，直接忽略**********】\e[0m"
    echo -e "\e[0;31m  【*******挖矿界面出现403，400 红色提示，不是报错，直接忽略**********】\e[0m"
    echo -e "\e[0;32m  【*******运行成功之后会返回 Mining power大于10 ,该数值为信誉分  **********】\e[0m"
    echo -e "\e[0;31m  【*******运行失败一种情况会返回 Mining power=0**********】\e[0m"
    echo -e "\e[0;31m  【*******运行失败一种情况会返回 500 数值**********】\e[0m"
    echo -e "\e[0;31m  【*******运行失败一种情况会返回 Wallet  xxx  does not have master address 代表没有绑定主钱包**********】\e[0m"
    read -p "确认是否继续操作，确认输入y：" confirm
    export confirm
    if [ $confirm =  y ]; then
        if [ $allConfirm = y ];then
            confirm_path
        fi
        echo "INFO=========================path:$path"
        if [ -z "$path" ]; then
            mkdir -p $HOME/nimble && cd $HOME/nimble/nimble-miner-public
        else
            mkdir -p $path/nimble && cd $path/nimble/nimble-miner-public
        fi
        read -p "请输入需要运行的第几涨卡的序号（1，2，3，4..........）: " gpus_no
        export gpus_no
        read -p "请输入目前第$gpus_no张卡需要运行的子钱包地址: " sub_wallet
        DIRECTORY=nim_miner$gpus_no
        if [ -d "$DIRECTORY" ]; then
            echo "目录 $DIRECTORY 存在。"
        else
            echo "目录 $DIRECTORY 不存在。"
            cp -r nimble-miner-public  nim_miner$gpus_no
        fi
        cd nim_miner$gpus_no
        rm -rf my_model/
        make install
        source ./nimenv_localminers/bin/activate
        (( x = $gpus_no-1))
        screen -dmS nim$gpus_no bash -c "CUDA_VISIBLE_DEVICES=$x make run addr=$sub_wallet"
        echo -e "\e[0;32m  【*******tom哥已帮您第$gpus_no张卡后台运行成功**********】\e[0m"
        echo -e "\e[0;32m  【*******请输入命令 'screen -r nim$gpus_no' 查看运行状态。**********】\e[0m"
        echo -e "\e[0;32m  【*******tom哥已帮您操作成功**********】\e[0m"
        screen -ls
        echo -e "\e[0;32m  【*******tom哥为您提醒操作结果如上**********】\e[0m"
        back_main_menu
    fi 
}



function show_status_multiple(){
    echo -e "\e[0;32m  【*******tom哥温馨提醒**********】\e[0m"
    echo -e "\e[0;31m  【*******稍后进入挖矿界面之后，键盘上按ctrl+a+d 进行无损退出操作**********】\e[0m"
    echo -e "\e[0;31m  【*******稍后进入挖矿界面之后，键盘上按ctrl+a+d 进行无损退出操作**********】\e[0m"
    echo -e "\e[0;31m  【*******稍后进入挖矿界面之后，键盘上按ctrl+a+d 进行无损退出操作**********】\e[0m"
    echo -e "\e[0;31m  【*******不要进行其他操作，打断挖矿，导致奖励丢失**********】\e[0m"
    read -p "是否确认知道如何操作，确认输入y：" confirm
    export confirm
    if [ $confirm =  y ]; then
        read -p "请输入需要查看的第几张卡的序号（1，2，3，4........）的进程: " gpus_no
        screen -r nim$gpus_no
    else
        back_main_menu
    fi
}

function close_node_multiple(){
    echo -e "\e[0;32m  【*******tom哥温馨提醒**********】\e[0m"
    echo -e "\e[0;31m  【*******此操作会关闭当前所有挖矿进程**********】\e[0m"
    echo -e "\e[0;31m  【*******此操作会关闭当前所有挖矿进程**********】\e[0m"
    echo -e "\e[0;31m  【*******此操作会关闭当前所有挖矿进程**********】\e[0m"
    read -p "是否确认继续操作，确认输入y：" confirm
    export confirm
    if [ $confirm =  y ]; then
        read -p "请输入目前本机插的卡数: " gpus_num
        for i in $(seq 1 $gpus_num); do
            screen -X -S nim$i quit
            echo -e "\e[0;32m  【*******tom哥已帮您关闭当前第$i张卡的挖矿进程**********】\e[0m"
        done
        echo -e "\e[0;32m  【*******tom哥已帮您批量关闭当前挖矿进程成功**********】\e[0m"
        back_main_menu
    else
        back_main_menu
    fi
}

function close_node_appoint(){
    echo -e "\e[0;32m  【*******tom哥温馨提醒**********】\e[0m"
    echo -e "\e[0;31m  【*******此操作会关闭指定的第几卡的挖矿进程**********】\e[0m"
    echo -e "\e[0;31m  【*******此操作会关闭指定的第几卡的挖矿进程**********】\e[0m"
    echo -e "\e[0;31m  【*******此操作会关闭指定的第几卡的挖矿进程**********】\e[0m"
    read -p "是否确认继续操作，确认输入y：" confirm
    export confirm
    if [ $confirm =  y ]; then
        read -p "请输入需要关闭的第几张卡的序号（1，2，3，4........）: " gpus_no
        screen -X -S nim$gpus_no quit
        echo -e "\e[0;32m  【*******tom哥已帮您关闭当前第$gpus_no张卡的挖矿进程**********】\e[0m"
        back_main_menu
    else
        back_main_menu
    fi
}

function close_node_appoint_new_restart(){
    echo -e "\e[0;32m  【*******tom哥温馨提醒**********】\e[0m"
    echo -e "\e[0;31m  【*******此操作会重启指定的第几卡的挖矿进程-新钱包模式**********】\e[0m"
    echo -e "\e[0;31m  【*******此操作会重启指定的第几卡的挖矿进程-新钱包模式**********】\e[0m"
    echo -e "\e[0;31m  【*******此操作会重启指定的第几卡的挖矿进程-新钱包模式**********】\e[0m"
    read -p "是否确认继续操作，确认输入y：" confirm
    export confirm
    if [ $confirm =  y ]; then
        read -p "请输入需要重启的第几张卡的序号（1，2，3，4........）: " gpus_no
        screen -X -S nim$gpus_no quit
        echo -e "\e[0;32m  【*******tom哥已帮您关闭当前第$gpus_no张卡的挖矿进程**********】\e[0m"
        read -p "请输入目前第$gpus_no张卡需要申请的子钱包地址: " sub_wallet
        read -p "请输入目前第$gpus_no张卡需要申请的主钱包地址: " master_wallet
        confirm_path
        echo "INFO=========================path:$path"
        if [ -z "$path" ]; then
            mkdir -p $HOME/nimble && cd $HOME/nimble/nimble-miner-public
        else
            mkdir -p $path/nimble && cd $path/nimble/nimble-miner-public
        fi
        source ./nimenv_localminers/bin/activate
        (( x = $gpus_no-1))
        screen -dmS nim$gpus_no bash -c "CUDA_VISIBLE_DEVICES=$x make run addr=$sub_wallet master_wallet=$master_wallet"
        echo -e "\e[0;32m  【*******tom哥已帮您第$gpus_no张卡申请成功，已转为后台运行**********】\e[0m"    
        back_main_menu
    else
        back_main_menu
    fi
}

function close_node_appoint_new_restart_more(){
    echo -e "\e[0;32m  【*******tom哥温馨提醒**********】\e[0m"
    echo -e "\e[0;31m  【*******此操作会重启指定的第几卡的挖矿进程-新钱包模式**********】\e[0m"
    echo -e "\e[0;31m  【*******此操作会重启指定的第几卡的挖矿进程-新钱包模式**********】\e[0m"
    echo -e "\e[0;31m  【*******此操作会重启指定的第几卡的挖矿进程-新钱包模式**********】\e[0m"
    read -p "是否确认继续操作，确认输入y：" confirm
    export confirm
    if [ $confirm =  y ]; then
        read -p "请输入需要重启的第几张卡的序号（1，2，3，4........）: " gpus_no
        screen -X -S nim$gpus_no quit
        echo -e "\e[0;32m  【*******tom哥已帮您关闭当前第$gpus_no张卡的挖矿进程**********】\e[0m"
        read -p "请输入目前第$gpus_no张卡需要申请的子钱包地址: " sub_wallet
        read -p "请输入目前第$gpus_no张卡需要申请的主钱包地址: " master_wallet
        confirm_path
        echo "INFO=========================path:$path"
        if [ -z "$path" ]; then
            cd $HOME/nimble
        else
            cd $path/nimble
        fi
        DIRECTORY=nim_miner$gpus_no
        if [ -d "$DIRECTORY" ]; then
            echo "目录 $DIRECTORY 存在。"
        else
            echo "目录 $DIRECTORY 不存在。"
            cp -r nimble-miner-public  nim_miner$gpus_no
        fi
        cd nim_miner$gpus_no
        rm -rf my_model/
        make install
        source ./nimenv_localminers/bin/activate
        (( x = $gpus_no-1))
        screen -dmS nim$gpus_no bash -c "CUDA_VISIBLE_DEVICES=$x make run addr=$sub_wallet master_wallet=$master_wallet"
        echo -e "\e[0;32m  【*******tom哥已帮您第$gpus_no张卡申请成功，已转为后台运行**********】\e[0m"    
        back_main_menu
    else
        back_main_menu
    fi
}



function close_node_appoint_old_restart(){
    echo -e "\e[0;32m  【*******tom哥温馨提醒**********】\e[0m"
    echo -e "\e[0;31m  【*******此操作会重启指定的第几卡的挖矿进程-老钱包/已注册钱包模式**********】\e[0m"
    echo -e "\e[0;31m  【*******此操作会重启指定的第几卡的挖矿进程-老钱包/已注册钱包模式**********】\e[0m"
    echo -e "\e[0;31m  【*******此操作会重启指定的第几卡的挖矿进程-老钱包/已注册钱包模式**********】\e[0m"
    read -p "是否确认继续操作，确认输入y：" confirm
    export confirm
    if [ $confirm =  y ]; then
        read -p "请输入需要重启的第几张卡的序号（1，2，3，4........）: " gpus_no
        screen -X -S nim$gpus_no quit
        echo -e "\e[0;32m  【*******tom哥已帮您关闭当前第$gpus_no张卡的挖矿进程**********】\e[0m"
        read -p "请输入目前第$gpus_no张卡需要运行的子钱包地址: " sub_wallet
        confirm_path
        echo "INFO=========================path:$path"
        if [ -z "$path" ]; then
            mkdir -p $HOME/nimble && cd $HOME/nimble/nimble-miner-public
        else
            mkdir -p $path/nimble && cd $path/nimble/nimble-miner-public
        fi
        source ./nimenv_localminers/bin/activate
        (( x = $gpus_no-1))
        screen -dmS nim$gpus_no bash -c "CUDA_VISIBLE_DEVICES=$x make run addr=$sub_wallet"
        echo -e "\e[0;32m  【*******tom哥已帮您第$gpus_no张卡后台运行成功**********】\e[0m"    
        back_main_menu
    else
        back_main_menu
    fi
}


function close_node_appoint_old_restart_more(){
    echo -e "\e[0;32m  【*******tom哥温馨提醒**********】\e[0m"
    echo -e "\e[0;31m  【*******此操作会重启指定的第几卡的挖矿进程-老钱包/已注册钱包模式**********】\e[0m"
    echo -e "\e[0;31m  【*******此操作会重启指定的第几卡的挖矿进程-老钱包/已注册钱包模式**********】\e[0m"
    echo -e "\e[0;31m  【*******此操作会重启指定的第几卡的挖矿进程-老钱包/已注册钱包模式**********】\e[0m"
    read -p "是否确认继续操作，确认输入y：" confirm
    export confirm
    if [ $confirm =  y ]; then
        read -p "请输入需要重启的第几张卡的序号（1，2，3，4........）: " gpus_no
        screen -X -S nim$gpus_no quit
        echo -e "\e[0;32m  【*******tom哥已帮您关闭当前第$gpus_no张卡的挖矿进程**********】\e[0m"
        read -p "请输入目前第$gpus_no张卡需要运行的子钱包地址: " sub_wallet
        confirm_path
        echo "INFO=========================path:$path"
        if [ -z "$path" ]; then
            cd $HOME/nimble
        else
            cd $path/nimble
        fi
        DIRECTORY=nim_miner$gpus_no
        if [ -d "$DIRECTORY" ]; then
            echo "目录 $DIRECTORY 存在。"
        else
            echo "目录 $DIRECTORY 不存在。"
            cp -r nimble-miner-public  nim_miner$gpus_no
        fi
        cd nim_miner$gpus_no
        rm -rf my_model/
        make install
        source ./nimenv_localminers/bin/activate
        (( x = $gpus_no-1))
        screen -dmS nim$gpus_no bash -c "CUDA_VISIBLE_DEVICES=$x make run addr=$sub_wallet"
        echo -e "\e[0;32m  【*******tom哥已帮您第$gpus_no张卡后台运行成功**********】\e[0m"    
        back_main_menu
    else
        back_main_menu
    fi
}


function test_gpu(){
    nvidia-smi
    echo -e "\e[0;32m  【*******tom哥温馨提醒**********】\e[0m"
    echo -e "\e[0;32m 出现 command not found 代表驱动未安装(针对单卡测试)   \e[0m"
    back_main_menu
}

function test_connection(){
    curl huggingface.co
    echo -e "\e[0;32m  【*******tom哥温馨提醒**********】\e[0m"
    echo -e "\e[0;32m 测试结束，没有东西返回代表网络不通   \e[0m"
    back_main_menu
}

function install_cuda(){
    echo -e "\e[0;32m  【*******tom哥温馨提醒**********】\e[0m"
    echo -e "\e[0;32m 驱动安装地址如下,自行下载安装，推荐使用对应显卡的最新版本  \e[0m"
    echo -e "\e[0;31m https://developer.nvidia.com/cuda-toolkit-archive  \e[0m"
    echo -e "\e[0;32m 请注意linux 和wsl 版本不一样  \e[0m"
    back_main_menu
}

function personal(){
    echo "关于程序运行中的一些常见情况"
    echo "1. 403和400不是程序运行报错，要留意后面的语句提醒，只有当出现主钱包未绑定或者mining power 为0或者出现错误代码500的情况才会不正常工作"
    echo "2. 大陆用户必须翻墙使用，且保持相关节点稳定且上传比较高，需要上传一定的流量，上传不成功是没有奖励获取的"
    echo "3. 新钱包未开放注册，未注册的钱包禁止使用挖矿命令，即使运行也是不成功，且钱包地址不生效"
    echo "4. 禁止使用多卡一地址运行，会被判断作弊，如果发现mining power降低或者为0 就是钱包被当作作弊处理了"
    echo "5. 新钱包使用机制是一主一子配对使用的，如果是多张卡就需要N x 2 的钱包，请先提前准备好钱包"
    echo "6. 如果使用过程有问题欢迎来官方dc群找tom解答，谢谢"
    back_main_menu
}

function computing_power_meter(){
    echo -e "\e[0;32m  【*******tom哥温馨提醒**********】\e[0m"
    echo -e "\e[0;32m  【*******以下为社区自主收集，仅作参考**********】\e[0m"
    echo -e "\e[0;32m  【*******RTX 4000 Series:**********】\e[0m"
    echo "******- RTX 4090 = 17 it/s********"
    echo "******- RTX 4080S = 12.5 it/s********"
    echo "******- RTX 4080 = 11 it/s********"
    echo "******- RTX 4070Ti = 9 it/s********"
    echo -e "\e[0;32m  【*******RTX 3000 Series:**********】\e[0m"
    echo "******- RTX 3090Ti = 11.8 it/s********"
    echo "******- RTX 3090 = 10 it/s********"
    echo "******- RTX 3080Ti = 9 it/s********"
    echo "******- RTX 3080 = 8 it/s********"
    echo "******- RTX 3070Ti = 7.5 it/s********"
    echo "******- RTX 3060Ti = 5.6 it/s********"
    echo -e "\e[0;32m  【*******Other NVIDIA GPUs:**********】\e[0m"
    echo "******- 6000 Ada = 14 it/s********"
    echo "******- L40 = 13.6 it/s********"
    echo "******- L40S = 13.5 it/s********"
    echo "******- A100 = 10.2 it/s********"
    echo "******- A6000 = 9.6 it/s********"
    echo "******- A40 = 8.7 it/s********"
    echo "******- A5000 = 7.92 it/s********"
    echo "******- A4500 = 6.9 it/s********"
    echo "******- 4000 Ada = 5.9 it/s********"
    echo "******- A4000 = 5.25 it/s********"
    back_main_menu
}

function uninstall_node(){
    echo -e "\e[0;32m  【*******tom哥温馨提醒**********】\e[0m"
    echo -e "\e[0;31m  【*******该操作会删除整个nim程序，请谨慎操作！！！！！！！！**********】\e[0m"
    echo -e "\e[0;31m  【*******该操作会删除整个nim程序，请谨慎操作！！！！！！！！**********】\e[0m"
    echo -e "\e[0;31m  【*******该操作会删除整个nim程序，请谨慎操作！！！！！！！！**********】\e[0m"
    read -p "是否确定,确认输入y?  " confirm
    if [ "$confirm" = y ]; then
            confirm_path
            echo "INFO=========================path:$path"
            echo "再见了，大兄弟"
            if [ -z "$path" ]; then
                rm -rf $HOME/nimble
            else
                rm -rf $path/nimble
            fi
    fi
    back_main_menu

}

function back_main_menu(){
    # echo "输入m 返回主菜单,输入q 退出"
    read -p "输入m 返回主菜单,输入q 退出: " commond
    export commond
    if [ $commond =  m ]; then
        main_menu_ch    
    fi
}


function query_estimated_revenue() {
  confirm_path
  echo "INFO=========================path:$path"
  if [ -z "$path" ]; then
      mkdir -p $HOME/nimble && cd $HOME/nimble/nimble-miner-public
  else
      mkdir -p $path/nimble && cd $path/nimble/nimble-miner-public
  fi
  apt install jq
  read -p "请输入你要查询的挖矿子钱包地址： " sub_wallet
  export sub_wallet
  read -p "请输入你要查询的日期，日期格式为（yyyy-MM-dd 参考 2024-07-22 ）： " date
  export date
  echo -e "\e[0;32m  【*******tom哥温馨提醒 查询结果如下 **********】\e[0m"
  echo '总共完成任务----------------------------'
  jq '.[] |  select(.WalletAddr | contains("'$sub_wallet'")) and  select(.CompletedTime | contains("'$date'")) ' my_logs.json  | wc -l
  echo '失败次数--------------------------------'
  jq '.[] | select(.WalletAddr | contains("'$sub_wallet'"))  and  select(.CompletedTime | contains("'$date'")) and select(.Status | contains("Failed"))'  my_logs.json  | wc -l
  echo '成功次数---------------------------------'
  jq '.[] | select(.WalletAddr | contains("'$sub_wallet'"))  and  select(.CompletedTime | contains("'$date'")) and select(.Status | contains("Success"))'  my_logs.json  | wc -l
  echo '预计收入-----------------------------------'
  jq '.[] | select(.WalletAddr | contains("'$sub_wallet'"))  and  select(.CompletedTime | contains("'$date'")) and select(.Status | contains("Success"))'  my_logs.json  | wc -l
  echo -e "\e[0;32m  【*******tom哥温馨提醒 以上结果只是查询本地记录 只做参考 不做任何证据证明 **********】\e[0m"
  back_main_menu
}

function main_menu_ch(){
    clear
    allConfirm=y
    echo "请选择要执行的操作:"
    echo "===================================一键模式系列（适用于小白和新机）================================================================="
    echo "1. 一键挖矿 --单卡模式----即只有一张显卡  ) "
    echo "2. 一键挖矿 --多卡模式----即有多张显卡 -----2卡8卡机系列等 ) "
    echo "3. 一键挖矿 --多卡模式----即有多张显卡 -----2卡8卡机系列等-----多目录 ) "
    echo "====================================常规装机模式===================================================================================="
    echo "4. 安装所需的依赖环境  ) "
    echo "5. 安装钱包程序  ) "
    echo "6. 安装挖矿程序  ) "
    echo "7. 一键更新挖矿程序  ) "
    echo "======================================常用指令======================================================================================"
    echo "8. 批量生成钱包地址  ) "
    echo "9. 查询钱包余额  ----主钱包) "
    echo "10. 查看本地上传日志  ) "
    echo "11. 查询预估收益  ) "
    echo "===================================快捷启动（已经安装好了环境）单卡================================================================="
    echo "12. 新钱包地址挖矿----适用于未注册过的钱包地址  ) "
    echo "13. 老钱包地址挖矿----适用于已注册过的钱包地址  ) "
    echo "14. 查看当前nim进程  ) "
    echo "15. 关闭nim进程  ) "
    echo "===================================快捷启动（已经安装好了环境）多卡================================================================="
    echo "16. 新钱包地址多卡挖矿----适用于未注册过的钱包地址-----批量模式  ) "
    echo "17. 新钱包地址多卡挖矿----适用于未注册过的钱包地址-----批量模式-----多目录  ) "
    echo "18. 老钱包地址多卡挖矿----适用于已注册过的钱包地址-----批量模式  ) "
    echo "19. 老钱包地址多卡挖矿----适用于已注册过的钱包地址-----批量模式------多目录  ) "
    echo "20. 新钱包地址多卡挖矿----适用于未注册过的钱包地址-----指定某张卡  ) "
    echo "21. 新钱包地址多卡挖矿----适用于未注册过的钱包地址-----指定某张卡-----多目录  ) "
    echo "22. 老钱包地址多卡挖矿----适用于已注册过的钱包地址-----指定某张卡  ) "
    echo "23. 老钱包地址多卡挖矿----适用于已注册过的钱包地址-----指定某张卡-----多目录  ) "
    echo "24. 查看当前多卡nim进程  ) "
    echo "25. 关闭多卡nim进程 --------批量模式 ) "
    echo "26. 关闭多卡nim进程 --------指定模式 ) "
    echo "27. 关闭多卡nim进程 --------指定模式------加重新启动----新钱包申请 ) "
    echo "28. 关闭多卡nim进程 --------指定模式------加重新启动----老钱包运行 ) "
    echo "=================================================辅助测试工具======================================================================="
    echo "29. 测试显卡驱动 ) "
    echo "30. 测试连接huggingface.co ) "
    echo "31. 显卡驱动安装 ) "
    echo "==================================================建议和参考========================================================================"
    echo "32. 相关参考和建议 "
    echo "33. 参考算力表 "
    echo "==================================================说再见系列========================================================================"
    echo "34. 卸载nimble挖矿 "
    read -p "请输入选项（1-34）: " OPTION
    case $OPTION in
    1) allConfirm=n && one_click_one_gpu ;;
    2) allConfirm=n && one_click_gpus ;;
    3) allConfirm=n && one_click_gpus_more ;;
    4) allConfirm=y && install_environments ;;
    5) allConfirm=y && install_wallet ;;
    6) allConfirm=y && install_nim ;;
    7) update_nim ;;
    8) allConfirm=y && create_wallet ;;
    9) check_balance ;;
    10) view_upload ;;
    11) query_estimated_revenue ;;
    12) allConfirm=y && start_with_new_one_gpu ;;
    13) allConfirm=y && start_with_old_one_gpu ;;
    14) show_status_one_gpu ;;
    15) close_node_one_gpu ;;
    16) start_with_new_gpus ;;
    17) start_with_new_gpus_more ;;
    18) start_with_old_gpus ;;
    19) start_with_old_gpus_more ;;
    20) start_with_new_gpus_appoint ;;
    21) start_with_new_gpus_appoint_more ;;
    22) start_with_old_gpus_appoint ;;
    23) start_with_old_gpus_appoint_more ;;
    24) show_status_multiple ;;
    25) close_node_multiple ;;
    26) close_node_appoint ;;
    27) close_node_appoint_new_restart ;;
    28) close_node_appoint_old_restart ;;
    29) test_gpu ;;
    30) test_connection ;;
    31) install_cuda ;;
    32) personal ;;
    33) computing_power_meter ;;
    34) uninstall_node ;;
    *) echo "无效选项。" ;;
    esac
}

# 引导-ch
function guide_ch() {
    clear
    echo -e "\e[0;32m  【***************************请认真阅读以下内容，稍后将会有用（项目介绍和挖矿提醒）****************************************】\e[0m"
    echo -e "\e[0;32m 温馨提醒该程序适用于nim ubuntu教程,同样也适用windows下的wsl的ubuntu系统。 \e[0m"
    echo -e "\e[0;32m 项目运行前提条件需要cuda驱动的显卡，其他不赞同纯cpu的或者mac系列且不推荐进行挖矿。推荐4090最佳，其他的提供了算力表可进行查看 \e[0m"
    echo -e "\e[0;32m 项目介绍Nim是真AI训练项目，即使用gpu训练模型上传训练结果来获取相关的奖励  \e[0m"
    echo -e "\e[0;32m NIM相关模型获取是连接的huggingface.co,所以国内挖矿的必备条件是进行翻墙操作 \e[0m"
    echo -e "\e[0;31m 关于矿工关心的收益问题，目前项目处于前期，获取的积分是一比一兑换主网代币的，所以目前无法进行交易。 \e[0m"
    echo -e "\e[0;31m 关于项目余额更新机制目前处于不定期更新状态，所以余额查询一直是不及时的，请深刻理解这一点 \e[0m"
    echo -e "\e[0;31m 关于挖矿过程，NIM是处于任务机制，就是先接取任务再训练任务再上传训练结果这个是一个完整的过程，重复如此，一次完整的记录经过后台校验之后会给一个代币，所以更新是不及时的 \e[0m"
    echo -e "\e[0;32m 关于挖矿过程常见问题如下 \e[0m"
    echo -e "\e[0;32m 问题一：挖矿界面初期经常出现403，400 这个是错误吗？ \e[0m"
    echo -e "\e[0;31m 答： 这个不是错误是正常的，正在等待接收任务，请耐心等待，等待时间不等，尤其新钱包等待时间有可能尤其的长，正常现象 \e[0m"
    echo -e "\e[0;32m 问题二：我怎么知道是在正常进行挖矿了？ \e[0m"
    echo -e "\e[0;31m 答：如果从来没有挖矿过的机器，第一次会进行模型的下载会出现下载的进度条. 然后正常的挖矿状态是会出现如下内容  \e[0m"
    echo -e "\e[0;32m {‘loss’:0.xxxxx,'grad_norm':xxxxxxx............................}  \e[0m"
    echo -e "\e[0;32m {‘loss’:0.xxxxx,'grad_norm':xxxxxxx............................}  \e[0m"
    echo -e "\e[0;32m {‘loss’:0.xxxxx,'grad_norm':xxxxxxx............................}  \e[0m"
    echo -e "\e[0;32m 进度条  xxx/ 任务包数   已进行时间/预计剩余时间   实时算力 it/s  \e[0m"
    echo -e "\e[0;32m 问题三：出现403之后返回的信息里面包含的 Mining power 是什么意思 \e[0m"
    echo -e "\e[0;31m 答：这个数值是当前信誉系统的信誉值，新钱包注册之后如果成功会返回10或者5只要不为0即为正常。老钱包目前这个数值应该是和余额有关 \e[0m"
    echo -e "\e[0;32m 问题四：挖矿界面上有时候会出现 nvidia-smi: [errno 2]一行白色 这个是错误吗 \e[0m"
    echo -e "\e[0;31m 答：这个不是错误，正常跑即可 \e[0m"
    echo -e "\e[0;32m 问题四：挖矿界面上运行一段时间之后会出现一行绿色字体 Address:xxxxxxxxxxxxxxxxx  executed the task 是什么意思 \e[0m"
    echo -e "\e[0;31m 答：这个是完成了一次任务，然后会执行上传操作，如果网络不稳定会进行五次的重试，如果都失败了就代表网络不稳定，上传不成功是没有奖励获取的，即这次是无效任务。 \e[0m"
    echo -e "\e[0;31m 出现这个之后会继续进行任务的等待，不同钱包地址等待时间长短不一是正常现象，等下次下发任务 \e[0m"
    echo -e "\e[0;32m 问题五：如果是作为新钱包申请，我怎么知道有没有申请成功？ \e[0m"
    echo -e "\e[0;31m 答：403返回的Mining power不为0即可，为0代表无效钱包，更换新的钱包地址且在钱包开放之后进行钱包申请注册操作 \e[0m"
    echo -e "\e[0;32m 问题六：这个占用比较大的存储空间吗 \e[0m"
    echo -e "\e[0;31m 答：不占用多大的空间，程序自带自动校验空间且删除残余训练结果，挖矿界面上 上传完训练结果之后会出现几行红字 Deleted the model 就是该操作 \e[0m"
    echo -e "\e[0;32m 问题七：运行老钱包地址之后有的会出现 Wallet does not have master address是什么意思  \e[0m"
    echo -e "\e[0;31m 答：这是运行了错误的命令，没有注册成功，这个地址是废的没有绑定主钱包，请重新创建钱包地址，利用新钱包地址挖矿功能进行相关的新地址申请 \e[0m"
    echo -e "\e[0;32m 问题八：网页端查询余额有时候用不了是什么问题  \e[0m"
    echo -e "\e[0;31m 答：网页端查询是社区人员自发创建的方式为了方便查询，这个不是官方的，也不归官方维护，官方提供的查询余额方式在本脚本内 \e[0m"
    echo -e "\e[0;32m 问题九：如果我有多张gpu,我应该怎么配置钱包？  \e[0m"
    echo -e "\e[0;31m 答：目前官方提供的新钱包方式是一主一子，即你有几张卡就要创建几对的钱包地址就是nx2的钱包地址，老钱包之前的绑定关系不受此限制，该内容正确性验证于2024年7月22日 \e[0m"
    echo -e "\e[0;32m 问题十：我能不能使用一张卡运行多对主子关系或者是多张卡运行一对主子钱包  \e[0m"
    echo -e "\e[0;31m 答：该方式是被严令禁止的会被判断为作弊，一分奖励都没有，请切记！！！！！ \e[0m"
    echo -e "\e[0;32m 问题十一：我有一段时间没有更新余额了是否正常或者新钱包查询余额是0是正常的吗  \e[0m"
    echo -e "\e[0;31m 答：余额更新制度目前本来就是不及时的，这是正常现象，尤其新钱包不更新很正常，请耐心等待，如果实在不放心直接去DC开票即可，不用反复提问  \e[0m"
    confirm_continue
}

function tips_openclash() {
  echo "******************************************************************************************************************************"
  echo "******************************************************************************************************************************"
  echo "******************************************************************************************************************************"
  echo -e "\e[0;32m确认当前网络模式是否可以连接外网，可以输入y,不可以使用全局代理模式输入n。\e[0m"
  echo -e "\e[0;32m提醒上级代理clash等程序需要开启Tun模式，服务模式，局域网连接，关闭防火墙。\e[0m"
  read -p "请输入： " commond
  export command
  if [ $commond =  n ]; then
      open_clash
  fi
  main_menu_ch
}

function ask_question() {
    ###### 进行问答模式 避免相关人员不看操作 不尊重我的劳动成功
    question1
    question2
    question3
    question4
    question5
    question6
    question7
    question8
    question9
}

function question1() {
  echo -e "\e[0;32m 问题：NIM可以使用MAC或者纯cpu进行挖矿吗 \e[0m"
  echo -e "\e[0;32m 选项1：可以 \e[0m"
  echo -e "\e[0;32m 选项2：可以，但不推荐 \e[0m"
  echo -e "\e[0;32m 选项3：不可以，但是坚持要这么做也可以 \e[0m"
  read -p "请输入答案（数字）: " model
  if  [ "$model" -eq 2 ] || [ "$model" -eq 3 ]  ;then
     echo -e "\e[0;32m 回答正确 \e[0m"
  else
    exit  0
  fi
}

function question2() {
  echo -e "\e[0;32m 问题：挖矿界面上如果出现 400  Service not available 是报错吗 \e[0m"
  echo -e "\e[0;32m 选项1：是 \e[0m"
  echo -e "\e[0;32m 选项2：不是 \e[0m"
  read -p "请输入答案（数字）: " model
  if  [ "$model" -eq 2 ]  ;then
     echo -e "\e[0;32m 回答正确 \e[0m"
  else
    exit  0
  fi
}

function question3() {
  echo -e "\e[0;32m 问题：NIM的余额更新制度是怎么样的 \e[0m"
  echo -e "\e[0;32m 选项1：不实时 \e[0m"
  echo -e "\e[0;32m 选项2：实时 \e[0m"
  read -p "请输入答案（数字）: " model
  if  [ "$model" -eq 1 ]  ;then
     echo -e "\e[0;32m 回答正确 \e[0m"
  else
    exit  0
  fi
}

function question4() {
  echo -e "\e[0;32m 问题：我可以使用一对钱包地址进行多张显卡挖矿吗 \e[0m"
  echo -e "\e[0;32m 选项1：可以 \e[0m"
  echo -e "\e[0;32m 选项2：不可以 \e[0m"
  read -p "请输入答案（数字）: " model
  if  [ "$model" -eq 2 ]  ;then
     echo -e "\e[0;32m 回答正确 \e[0m"
  else
    exit  0
  fi
}

function question5() {
  echo -e "\e[0;32m 问题：如果我想查询余额该怎么做 \e[0m"
  echo -e "\e[0;32m 选项1：利用社区提供的网页端查询余额 \e[0m"
  echo -e "\e[0;32m 选项2：官方提供的命令行查询余额 \e[0m"
  echo -e "\e[0;32m 选项3：使用本脚本的查询余额功能进行查询 \e[0m"
  read -p "请输入答案（数字）: " model
  if  [ "$model" -eq 1 ] || [ "$model" -eq 2 ] || [ "$model" -eq 3 ]  ;then
     echo -e "\e[0;32m 回答正确 \e[0m"
  else
    exit  0
  fi
}

function question6() {
  echo -e "\e[0;32m 问题：我想使用该脚本以下哪个方式是对的 \e[0m"
  echo -e "\e[0;32m 选项1：翻墙使用 \e[0m"
  echo -e "\e[0;32m 选项2：直接使用 \e[0m"
  echo -e "\e[0;32m 选项3： 运行环境处于可访问国外网站的情况下 \e[0m"
  read -p "请输入答案（数字）: " model
  if  [ "$model" -eq 1 ] ||  [ "$model" -eq 3 ] ;then
     echo -e "\e[0;32m 回答正确 \e[0m"
  else
    exit  0
  fi
}

function question7() {
  echo -e "\e[0;32m 问题：AMD显卡是否可以此脚本进行挖矿 \e[0m"
  echo -e "\e[0;32m 选项1：可以 \e[0m"
  echo -e "\e[0;32m 选项2：不可以 \e[0m"
  read -p "请输入答案（数字）: " model
  if  [ "$model" -eq 2 ]   ;then
     echo -e "\e[0;32m 回答正确 \e[0m"
  else
    exit  0
  fi
}

function question8() {
    echo -e "\e[0;32m 问题：如何知道目前处于挖矿成功状态下 \e[0m"
    echo -e "\e[0;32m 选项1：新钱包申请返回Mining power = 0 \e[0m"
    echo -e "\e[0;32m 选项2：新钱包申请返回Mining power > 0 \e[0m"
    echo -e "\e[0;32m 选项3：挖矿界面显示挖矿成功 \e[0m"
    read -p "请输入答案（数字）: " model
    if  [ "$model" -eq 2 ]   ;then
       echo -e "\e[0;32m 回答正确 \e[0m"
    else
      exit  0
    fi
}

function question9() {
    echo -e "\e[0;32m 问题：我刚使用新钱包进行挖矿，查询余额返回0是否正确 \e[0m"
    echo -e "\e[0;32m 选项 2 ：错误 \e[0m"
    echo -e "\e[0;32m 选项 1 ：正确 \e[0m"
    read -p "请输入答案（数字）: " model
    if  [ "$model" -eq 1 ]   ;then
       echo -e "\e[0;32m 回答正确 \e[0m"
    else
      exit  0
    fi
}

function congratulations() {
    echo -e "\e[0;32m 恭喜你达到入门门槛了！！！！！！！！！！！！ \e[0m"
    echo -e "\e[0;32m 如果你不想下次依旧问答使用，请使用以下方式进行注解代码 \e[0m"
    echo -e "\e[0;31m 编辑 Nimble.sh 文件, 把 文末的 ask_question congratulations 方法 注解掉  \e[0m"
}

function confirm_continue(){
  read -p "请确认已经看过以上内容且理解相关内容,确认输入y: " contine
  export contine
  if [ $contine = y ]; then
     echo -e "\e[0;32m  【*******感谢理解，进入下一步**********】\e[0m"
  else
    exit 0
  fi
}

preface
confirm_continue
root_model_ch
guide_ch
ask_question
congratulations
#ask_question
#congratulations
tips_openclash
main_menu_ch





