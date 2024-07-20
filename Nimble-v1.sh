#!/bin/bash

# 检查是否以root用户运行脚本
if [ "$(id -u)" != "0" ]; then
    echo "此脚本需要以root用户权限运行。/This script needs to be run with root user privileges."
    echo "请尝试使用 'sudo -i' 命令切换到root用户，然后再次运行此脚本。/Please try to switch to root user with 'sudo -i' command, then run this script again."
    exit 1
fi

# 导入Socks5代理
echo "请输入HTTP代理地址 (格式为 host:port 参考 192.168.1.12:7899)，如不需要代理请留空"
echo "Please enter the HTTP proxy address (format host:port Reference 192.168.1.12:7899), leave blank if no proxy is needed"
read -p "请输入 / Please enter: " proxy
if [ ! -z "$proxy" ]; then
    export http_proxy=http://$proxy
    export https_proxy=http://$proxy
    echo "已设置HTTP代理为: $proxy /HTTP proxy is set to: $proxy"
else
    echo "未设置代理 /No proxy set"
fi


function install_environments() {
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
    
    echo "=============================恭喜基础环境已经安装好了 / Congratulations, the basic environment has been installed ==================================="
    # echo "输入m 返回主菜单,输入q 退出"
    read -p "输入m 返回主菜单,输入q 退出 / Enter m to return to the main menu, enter q to exit  : " commond
    export commond
    if [ $commond =  m ]; then
        main_menu    
    fi
}

function install_wallet() {
    # 克隆官方仓库并安装
    mkdir -p $HOME/nimble && cd $HOME/nimble
    git clone https://github.com/nimble-technology/wallet-public.git
    cd wallet-public
    make install
    echo "=============================钱包已经安装好了 / The wallet has been installed ==================================="
    # echo "输入m 返回主菜单,输入q 退出"
    read -p "输入m 返回主菜单,输入q 退出 / Enter m to return to the main menu, enter q to exit : " commond
    export commond
    if [ $commond =  m ]; then
        main_menu    
    fi
}


function install_nim() {
    mkdir -p $HOME/nimble && cd $HOME/nimble
    git clone https://github.com/nimble-technology/nimble-miner-public.git
    cd nimble-miner-public
    make install
    echo "=============================节点程序已经安装好了 / The node program has been installed==================================="
    # echo "输入m 返回主菜单,输入q 退出"
    read -p "输入m 返回主菜单,输入q 退出 / Enter m to return to the main menu, enter q to exit : " commond
    export commond
    if [ $commond =  m ]; then
        main_menu    
    fi
}


function create_wallet(){
    cd $HOME/nimble
    cd wallet-public
    echo "export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin" >> ~/.bashrc
    export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin
    make install
    # 创建钱包
    echo "首次创建至少需要生成两个钱包，一个作为主钱包，一个作为挖矿钱包，有几张卡就要生成几对，nX2，目前不需要提交审核了，只需要钱包地址开放，留心公告即可。"
    read -p "请输入你想要创建的钱包数量/Enter the number of wallets you want to create: " wallet_count
    for i in $(seq 1 $wallet_count); do
        wallet_name="wallet$i"
        nimble-networkd keys add $wallet_name --keyring-backend test
        echo "钱包 $wallet_name 已创建/Wallet $wallet_name has been created."
        echo "=============================备份好钱包和助记词，下方需要使用==================================="
        echo "=============================Make sure to backup your wallet and mnemonic phrase, it will be needed below==================================="

        # 确认备份
        read -p "是否已经备份好助记词? Have you backed up the mnemonic phrase? (y/n) " backup_confirmed
        if [ "$backup_confirmed" != "y" ]; then
                echo "请先备份好助记词,然后再继续执行脚本。/Please backup the mnemonic phrase first, then continue running the script."
                exit 1
        fi
    done

    
    # echo "输入m 返回主菜单,输入q 退出"
    read -p "输入m 返回主菜单,输入q 退出 / Enter m to return to the main menu, enter q to exit : " commond
    export commond
    if [ $commond =  m ]; then
        main_menu    
    fi
}


function start_with_new() {
    echo "温馨提醒未注册新钱包运行必须等官方开放钱包注册使用（留心官方开放公告），已经注册成功的新钱包可以直接使用"
    echo "Reminder: Unregistered new wallets must wait for the official wallet to be opened for registration and use (pay attention to the official opening announcement). New wallets that have been successfully registered can be used directly"
    # 启动挖矿
    read -p "请输入挖矿子钱包地址: Please enter the address of the mining sub wallet: " wallet_addr1
    read -p "请输入挖矿主钱包地址: Please enter the mining master wallet address: " wallet_addr2
    export wallet_addr1
    export wallet_addr2
    cd $HOME/nimble
    cd nimble-miner-public
    source ./nimenv_localminers/bin/activate
    screen -dmS nim bash -c "make run addr=$wallet_addr1 master_wallet=$wallet_addr2"
    echo "运行成功，请输入命令 'screen -r nim' 查看运行状态。/Installation complete, enter 'screen -r nim' to view the running status."
    # echo "输入m 返回主菜单,输入q 退出"
    read -p "输入m 返回主菜单,输入q 退出 / Enter m to return to the main menu, enter q to exit : " commond
    export commond
    if [ $commond =  m ]; then
        main_menu    
    fi
} 


function start_with_old() {
    echo “老钱包运行只需要输入子钱包地址即可/To run the old wallet, simply enter the sub wallet address”
    # 启动挖矿
    read -p "请输入挖矿子钱包地址: Please enter your mining wallet address: " wallet_addr1
    export wallet_addr1
    cd $HOME/nimble
    cd nimble-miner-public
    source ./nimenv_localminers/bin/activate
    screen -dmS nim bash -c "make run addr=$wallet_addr1"
    echo "运行成功，请输入命令 'screen -r nim' 查看运行状态。/Installation complete, enter 'screen -r nim' to view the running status."
    # echo "输入m 返回主菜单,输入q 退出"
    read -p "输入m 返回主菜单,输入q 退出 / Enter m to return to the main menu, enter q to exit : " commond
    export commond
    if [ $commond =  m ]; then
        main_menu    
    fi
} 


# 查看当前状态
function show_status() {
    screen -r nim
}

function check_balance(){
    echo “有社区大佬提供的网页查询地址如下”
    echo “The webpage query address provided by the community leader is as follows”
    echo “https://nimble.urlrevealer.com”
    read -p "请输入挖矿主钱包地址: Please enter your mining wallet address: " wallet_addr1
    export wallet_addr1
    cd $HOME/nimble
    cd nimble-miner-public
    source ./nimenv_localminers/bin/activate
    make check addr=$wallet_addr1
    # echo "输入m 返回主菜单,输入q 退出"
    read -p "输入m 返回主菜单,输入q 退出 / Enter m to return to the main menu, enter q to exit : " commond
    export commond
    if [ $commond =  m ]; then
        main_menu    
    fi
}


function uninstall_node() {
    echo "温馨提醒该操作会删除nim程序，请谨慎操作！！！！！！！！"
    echo "Kind reminder that this operation will delete the nim program, please proceed with caution！！！！！！！！"
    read -p "是否确定? /Are you sure? (y/n) " confirm
    if [ "$confirm" != "y" ]; then
            echo "再见了，大兄弟/Goodbye, bro"
            screen -S nim -X quit
            rm -rf $HOME/nimble
            exit 1
    fi
    # echo "输入m 返回主菜单,输入q 退出"
    read -p "输入m 返回主菜单,输入q 退出 / Enter m to return to the main menu, enter q to exit : " commond
    export commond
    if [ $commond =  m ]; then
        main_menu    
    fi
}


function close_node(){
    screen -S nim -X quit
    echo "已经关闭nim进程 / The nim process has been closed"
    # echo "输入m 返回主菜单,输入q 退出"
    read -p "输入m 返回主菜单,输入q 退出 / Enter m to return to the main menu, enter q to exit : " commond
    export commond
    if [ $commond =  m ]; then
        main_menu    
    fi
}

function test_gpu(){
    nvidia-smi
    echo "测试结束(出现 command not found 代表驱动未安装) / Test completed（Command not found indicates that the driver is not installed）"
    # echo "输入m 返回主菜单,输入q 退出"
    read -p "输入m 返回主菜单,输入q 退出 / Enter m to return to the main menu, enter q to exit : " commond
    export commond
    if [ $commond =  m ]; then
        main_menu    
    fi
}

function test_connection(){
    curl huggingface.co
    echo "测试结束，没有东西返回代表网络不通 / The test is over, and if nothing returns, it means the network is not working"
    # echo "输入m 返回主菜单,输入q 退出"
    read -p "输入m 返回主菜单,输入q 退出 / Enter m to return to the main menu, enter q to exit : " commond
    export commond
    if [ $commond =  m ]; then
        main_menu    
    fi
}


function install_cuda(){
    echo "驱动安装地址如下,自行下载安装，推荐使用对应显卡的最新版本"
    echo "The installation address for the driver is as follows. Please download and install it yourself. It is recommended to use the latest version of the corresponding graphics card"
    echo "https://developer.nvidia.com/cuda-toolkit-archive"
    # echo "输入m 返回主菜单,输入q 退出"
    read -p "输入m 返回主菜单,输入q 退出 / Enter m to return to the main menu, enter q to exit : " commond
    export commond
    if [ $commond =  m ]; then
        main_menu    
    fi
}


function view_upload(){
    echo “本地上传日志中成功记录不是最终的余额，以最后查询出来的余额为准，如果有问题可以及时开票提交”
    echo “The successful record in the local upload log is not the final balance. The final balance queried shall prevail. If there are any problems, invoices can be issued and submitted in a timely manner”
    read -p "请输入挖矿主钱包地址: Please enter your mining wallet address: " wallet_addr1
    export wallet_addr1
    cd $HOME/nimble
    cd nimble-miner-public
    source ./nimenv_localminers/bin/activate
    make logs
    # echo "输入m 返回主菜单,输入q 退出"
    read -p "输入m 返回主菜单,输入q 退出 / Enter m to return to the main menu, enter q to exit : " commond
    export commond
    if [ $commond =  m ]; then
        main_menu    
    fi
}



function personal(){
    echo "关于程序运行中的一些常见情况"
    echo "1. 403和400不是程序运行报错，要留意后面的语句提醒，只有当出现主钱包未绑定或者mining power 为0或者出现错误代码500的情况才会不正常工作"
    echo "2. 大陆用户必须翻墙使用，且保持相关节点稳定且上传比较高，需要上传一定的流量，上传不成功是没有奖励获取的"
    echo "3. 新钱包未开放注册，未注册的钱包禁止使用挖矿命令，即使运行也是不成功，且钱包地址不生效"
    echo "4. 禁止使用多卡一地址运行，会被判断作弊，如果发现mining power降低或者为0 就是钱包被当作作弊处理了"
    echo "5. 新钱包使用机制是一主一子配对使用的，如果是多张卡就需要N x 2 的钱包，请先提前准备好钱包"
    echo "6. 如果使用过程有问题欢迎来官方dc群找tom解答，谢谢"

    echo "Some common situations during program operation"
    echo "1. 403 and 400 are not program running errors. Please pay attention to the following statement reminders. Only when the main wallet is not bound, the mining power is 0, or error code 500 appears, will they not work properly"
    echo "2. Mainland users must use VPN and maintain stable nodes with high upload rates. They need to upload a certain amount of traffic, and there will be no rewards for unsuccessful uploads"
    echo "3. The new wallet is not open for registration. Unregistered wallets are prohibited from using mining commands, and even if run, it is unsuccessful. Additionally, the wallet address is not valid"
    echo "4. It is prohibited to run with multiple cards and one address, as it may be considered cheating. If the mining power is reduced or set to 0, the wallet will be treated as cheating"
    echo "5. The new wallet usage mechanism is a one master one child pairing. If there are multiple cards, an N x 2 wallet is required. Please prepare the wallet in advance"
    echo "6. If you have any questions during use, please feel free to contact Tom in the official DC group for answers. Thank you"

    # echo "输入m 返回主菜单,输入q 退出"
    read -p "输入m 返回主菜单,输入q 退出 / Enter m to return to the main menu, enter q to exit : " commond
    export commond
    if [ $commond =  m ]; then
        main_menu    
    fi
}


# 主菜单
function main_menu() {
    clear
    echo "温馨提醒该程序适用于nim ubuntu教程 / Kind reminder that this program is suitable for nim ubuntu tutorial"
    echo "该项目需要cuda驱动的显卡，推荐4090最佳 / This project requires a CUDA driven graphics card, and the best recommendation is 4090"
    echo "运行程序推荐测试显卡驱动是否安装正常 / It is recommended to test whether the graphics card driver is installed properly when running the program"
    echo "运行程序推荐测试连接huggingface.co是否正常 / Running the program recommends testing whether the connection to huggingface. co is working properly"
    echo "温馨提醒大陆用户使用必须翻墙使用 / Warm reminder to mainland users that they must climb over the wall when using"
    echo "############################################################################################"
    echo "############################################################################################"
    echo "############################################################################################"
    echo "请选择要执行的操作:          /Please select an operation to execute:"
    echo "1. 测试显卡驱动)             /Test graphics card driver "
    echo "2. 测试连接huggingface.co)   /Test connection huggingface. co "
    echo "3. 显卡驱动安装              /Installation of graphics card driver "
    echo "4. 安装所需的依赖环境)        /Install the required dependency environment "
    echo "5. 安装钱包程序)              /Install wallet program "
    echo "6. 安装挖矿程序)              /Install mining program "
    echo "7. 生成钱包地址）             /Generate wallet address "
    echo "8. 新钱包地址挖矿）           /New wallet address mining"
    echo "9. 老钱包地址挖矿）           /Old wallet address mining"
    echo "10. 查询钱包余额）             /Check wallet balance"
    echo "11. 卸载nimble挖矿）          /Uninstall nimble mining"
    echo "12. 关闭nim进程）             /Close the nim process"
    echo "13. 查看当前nim进程）         /View the current nim process"
    echo "14. 查看本地上传日志）         /View local upload logs"
    echo "15. 个人看法和新人提醒）      /Personal Opinion and Newcomer Reminder"
    read -p "请输入选项（1-15）: Please enter your choice (1-15): " OPTION

    case $OPTION in
    1) test_gpu ;;
    2) test_connection ;;
    3) install_cuda ;;
    4) install_environments ;;
    5) install_wallet ;;
    6) install_nim ;;
    7) create_wallet ;;
    8) start_with_new ;;
    9) start_with_old ;;
    10) check_balance ;;
    11) uninstall_node ;;
    12) close_node ;;
    13) show_status ;;
    14) view_upload ;;
    15) personal ;;
    *) echo "无效选项。/Invalid option." ;;
    esac
}

main_menu
