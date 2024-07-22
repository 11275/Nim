#!/bin/bash

function preface(){
    echo -e "\e[0;32m  【*******tom's Script Preface*****************】\e[0m"
    echo -e "\e[0;32m  【*******The script was created with the intention to help newcomers to Nim understand and mine more quickly*****************】\e[0m"
    echo -e "\e[0;32m  【*******This script does not profit from any information collection, it is open-source and safe to use*****************】\e[0m"
    echo -e "\e[0;32m  【*******This is a script I, as a beginner, have heartfully created, containing many tips and guidance. Please respect my effort*****************】\e[0m"
    echo -e "\e[0;32m  【*******If you are a complete novice, without basic Linux command knowledge, it is not recommended to use this script*****************】\e[0m"
    echo -e "\e[0;32m  【*******Please carefully review my guidance and tips. If you're not comfortable with this approach, please delete the script*****************】\e[0m"
    echo -e "\e[0;32m  【*******This is the delete command rm -rf Nimble.sh*****************】\e[0m"
}


function root_model_ch(){
    # Check if the script is being run as root user
    if [ "$(id -u)" != "0" ]; then
        echo -e "\e[0;31mThis script needs to be run as root user.\e[0m"
        echo -e "\e[0;31mPlease try using 'sudo -i' command to switch to root user, then run the script again.\e[0m"
        exit 1
    fi
}


function confirm_path(){
    echo -e "\e[0;32mThis program runs by default in the /root directory and will generate a nimable folder. Please confirm the program running path. If you need to modify it, please write the related path. If no modification is needed, just press enter to proceed.\e[0m"
    read -p "Please input: " path
    export path
    if [ ! -z "$path" ]; then
        echo "Path set to======$path============="
    else
        echo "No changes made, path is /root/nimble"
    fi
    path=$path
}

function one_click_one_gpu(){
    confirm_path
    echo "INFO=========================path:$path"
    echo -e "\e[0;32m  【*******$allConfirm**********】\e[0m"
    echo -e "\e[0;32m  【*******tom's friendly reminder: This operation is only for new machines that have not installed the NIM program/or want to install in a different path**********】\e[0m"
    echo -e "\e[0;32m  【*******tom's friendly reminder: This operation is limited to single-card computers**********】\e[0m"
    read -p "Is there confirmation for the operation, confirm by typing y: " confirm
    export confirm
    if [ $confirm =  y ]; then
        install_environments
        install_wallet
        install_nim
        create_wallet
        echo -e "\e[0;32m  【*******tom's friendly reminder: Next, you will proceed with mining operations, please choose the running mode**********】\e[0m"
        echo -e "\e[0;32m  【*******New wallet running mode input  1**********】\e[0m"
        echo -e "\e[0;32m  【*******Old wallet/registered wallet running mode input  2**********】\e[0m"
        read -p "Please input (1 or 2): " model
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
    echo -e "\e[0;32m  【*******tom's friendly reminder: This operation is only for new machines that have not installed the NIM program/or want to install in a different path**********】\e[0m"
    echo -e "\e[0;32m  【*******tom's friendly reminder: This operation is limited to multi-card computers***********】\e[0m"
    read -p "Is there confirmation for the operation, confirm by typing y: " confirm
    export confirm
    if [ $confirm =  y ]; then
        install_environments
        install_wallet
        install_nim
        create_wallet
        echo -e "\e[0;32m  【*******tom's friendly reminder: Next, you will proceed with mining operations, please choose the running mode**********】\e[0m"
        echo -e "\e[0;32m  【*******New wallet running mode input  1**********】\e[0m"
        echo -e "\e[0;32m  【*******Old wallet/registered wallet running mode input  2**********】\e[0m"
        read -p "Please input (1 or 2): " model
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


function install_environments(){
    # confirm_path
    # echo "INFO=========================path:$path"
    echo -e "\e[0;32m  【*******tom's friendly reminder: This operation will only install the basic dependencies environment (python3.11 and go)**********】\e[0m"
    echo -e "\e[0;32m  【*******tom's friendly reminder: To execute the mining program, you must install the mining software (i.e., step 5)**********】\e[0m"
    if [ $allConfirm = n ];then
        install_environments_commond
    else
        read -p "Is there confirmation for the operation, confirm by typing y: " confirm
        export confirm
        if [ $confirm =  y ]; then
            install_environments_commond
            echo -e "\e[0;32m  【*******tom's friendly reminder: I have already installed the basic environment for you**********】\e[0m"
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
    echo -e "\e[0;32m  【*******tom's friendly reminder: I have already installed the wallet program for you**********】\e[0m"
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
    echo -e "\e[0;32m  【*******tom's friendly reminder: I have already installed the mining program for you**********】\e[0m"
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
    echo -e "\e[0;32m  【*******tom's friendly reminder: I have already updated the mining program for you**********】\e[0m"
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
    echo -e "\e[0;32m  【*******tom's friendly reminder: **********】\e[0m"
    echo -e "\e[0;32m  【*******Creating a wallet requires at least a pair, a main wallet and a sub-wallet. For multiple cards, generate nx2 multiples of wallets 2 4 6 8**********】\e[0m"
    echo -e "\e[0;32m  【*******Newly created wallets must wait for the relevant announcement before registration. Otherwise, even if registered, it will be an invalid wallet, unable to perform normal mining**********】\e[0m"
    read -p "Please enter the number of wallets you want to create: " wallet_count
    for i in $(seq 1 $wallet_count); do
        wallet_name="wallet$i"
        nimble-networkd keys add $wallet_name --keyring-backend test
        echo -e "\e[0;32m  【*******Wallet $wallet_name has been created**********】\e[0m"
    done
    echo -e "\e[0;32m  【*******tom's friendly reminder: I have already helped you batch generate wallets**********】\e[0m"
    echo -e "\e[0;31m  【*******Please copy and save all the relevant information (including wallet address and mnemonic) as the only credential for wallet recovery**********】\e[0m"
    echo -e "\e[0;31m  【*******Please copy and save all the relevant information (including wallet address and mnemonic) as the only credential for wallet recovery**********】\e[0m"
    echo -e "\e[0;31m  【*******Please copy and save all the relevant information (including wallet address and mnemonic) as the only credential for wallet recovery**********】\e[0m"
    echo -e "\e[0;32m  【*******Important thing say three times**********】\e[0m"
    read -p "Please confirm that you have saved everything, confirm by typing y: " confirm
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
    echo -e "\e[0;32m  【*******tom's friendly reminder: **********】\e[0m"
    echo -e "\e[0;32m  【*******There are currently two ways to check balance**********】\e[0m"
    echo -e "\e[0;32m  【*******The first way is through the web interface, enter the main wallet address, and click check balance**********】\e[0m"
    echo -e "\e[0;32m  【*******Below is the web address**********】\e[0m"
    echo -e "\e[0;31m  【*******https://nimble.urlrevealer.com/**********】\e[0m"
    echo -e "\e[0;32m  【*******The second way is the official provided method, which is this method. Please note that you must successfully upload a record at least once for the balance to update**********】\e[0m"
    read -p "Please enter the mining main wallet address: " master_wallet
    export master_wallet
    source ./nimenv_localminers/bin/activate
    make check addr=$master_wallet
    echo -e "\e[0;32m  【*******tom's friendly reminder: I have already helped you check the balance**********】\e[0m"
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
    echo -e "\e[0;32m  【*******tom's friendly reminder: **********】\e[0m"
    echo -e "\e[0;32m  【*******Viewing only shows the upload records, not the actual balance, as the current balance update mode is not fixed, so please be patient**********】\e[0m"
    echo -e "\e[0;32m  【*******If you really can't wait, you can go to the official dc to inquire**********】\e[0m"
    read -p "Is there confirmation to continue, confirm by typing y: " confirm
    export confirm
    if [ $confirm =  y ]; then
       source ./nimenv_localminers/bin/activate
       make logs
       echo -e "\e[0;32m  【*******tom's friendly reminder: I have already helped you view the current upload records**********】\e[0m"
    fi
    back_main_menu
}


function start_with_new_one_gpu(){
    echo -e "\e[0;32m  【*******tom's friendly reminder: **********】\e[0m"
    echo -e "\e[0;31m  【*******Please confirm that the current wallet registration is open**********】\e[0m"
    echo -e "\e[0;31m  【*******Please confirm that the current wallet registration is open**********】\e[0m"
    echo -e "\e[0;31m  【*******Please confirm that the current wallet registration is open**********】\e[0m"
    echo -e "\e[0;31m  【*******Mining interface appearing with 403, 400 red error messages, do not worry, ignore them**********】\e[0m"
    echo -e "\e[0;31m  【*******Mining interface appearing with 403, 400 red error messages, do not worry, ignore them**********】\e[0m"
    echo -e "\e[0;31m  【*******Mining interface appearing with 403, 400 red error messages, do not worry, ignore them**********】\e[0m"
    echo -e "\e[0;32m  【*******Registration success will return Mining power=10, this is the initial credit score  **********】\e[0m"
    echo -e "\e[0;31m  【*******Registration failure will return Mining power=0**********】\e[0m"
    echo -e "\e[0;31m  【*******Run failure will return a 500 value**********】\e[0m"
    read -p "Confirm if you want to continue, confirm by typing y: " confirm
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
        read -p "Please enter the mining sub-wallet address to register: " sub_wallet
        read -p "Please enter the mining main wallet address to register: " master_wallet
        export sub_wallet
        export master_wallet
        screen -dmS nim bash -c "make run addr=$sub_wallet master_wallet=$master_wallet"
        echo -e "\e[0;32m  【*******tom's friendly reminder: I have already helped you apply successfully, if you need to check the current mining status please input command 'screen -r nim' to view running status**********】\e[0m"
        back_main_menu
    fi
}


function start_with_old_one_gpu(){
    echo -e "\e[0;32m  【*******tom's friendly reminder**********】\e[0m"
    echo -e "\e[0;31m  【*******Mining interface appears with 403, 400 red error messages, not an error, ignore directly**********】\e[0m"
    echo -e "\e[0;31m  【*******Mining interface appears with 403, 400 red error messages, not an error, ignore directly**********】\e[0m"
    echo -e "\e[0;31m  【*******Mining interface appears with 403, 400 red error messages, not an error, ignore directly**********】\e[0m"
    echo -e "\e[0;32m  【*******Running successfully will return Mining power greater than 10, that number is the credit score**********】\e[0m"
    echo -e "\e[0;31m  【*******A failure case will return Mining power=0**********】\e[0m"
    echo -e "\e[0;31m  【*******A failure case will return 500 number**********】\e[0m"
    echo -e "\e[0;31m  【*******A failure case will return Wallet xxx does not have master address means no main wallet is bound**********】\e[0m"
    read -p "Confirm if you wish to continue operation, confirm by entering y：" confirm
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
        read -p "Please enter the sub-wallet address you want to mine: " sub_wallet
        export sub_wallet
        screen -dmS nim bash -c "make run addr=$sub_wallet"
        echo -e "\e[0;32m   [*******tom brother has successfully started background mining for you. To check the current mining status, please enter the command 'screen -r nim' to view running status.**********]"
        back_main_menu
    fi
}

function show_status_one_gpu(){
    echo -e "\e[0;32m   [*******tom brother's gentle reminder**********]"
    echo -e "\e[0;31m   [*******Later, when you enter the mining interface, press ctrl+a+d for a safe exit operation**********]"
    echo -e "\e[0;31m   [*******Later, when you enter the mining interface, press ctrl+a+d for a safe exit operation**********]"
    echo -e "\e[0;31m   [*******Later, when you enter the mining interface, press ctrl+a+d for a safe exit operation**********]"
    echo -e "\e[0;31m   [*******Do not perform any other operations that might interrupt mining and cause loss of rewards**********]"
    read -p "Do you confirm you know how to operate? Confirm by typing 'y': " confirm
    export confirm
    if [ $confirm =  y ]; then
        screen -r nim
    else
        back_main_menu
    fi
}

function close_node_one_gpu(){
    echo -e "\e[0;32m   [*******tom brother's gentle reminder**********]"
    echo -e "\e[0;31m   [*******This operation will close the current mining process**********]"
    echo -e "\e[0;31m   [*******This operation will close the current mining process**********]"
    echo -e "\e[0;31m   [*******This operation will close the current mining process**********]"
    echo -e "\e[0;31m   [*******This operation will close the current mining process**********]"
    read -p "Do you confirm to continue operation? Confirm by typing 'y': " confirm
    export confirm
    if [ $confirm =  y ]; then
        screen -X -S nim quit
        echo -e "\e[0;32m   [*******tom brother has helped you close the current mining process**********]"
        back_main_menu
    else
        back_main_menu
    fi
}

function start_with_new_gpus(){
     echo -e "\e[0;32m   [*******tom brother's gentle reminder**********]"
     echo -e "\e[0;31m   [*******Please confirm that the current wallet registration is open**********]"
     echo -e "\e[0;31m   [*******Please confirm that the current wallet registration is open**********]"
     echo -e "\e[0;31m   [*******Please confirm that the current wallet registration is open**********]"
     echo -e "\e[0;31m   [*******Ignore any 403 or 400 red error messages on the mining interface, as they are not errors**********]"
     echo -e "\e[0;31m   [*******Ignore any 403 or 400 red error messages on the mining interface, as they are not errors**********]"
     echo -e "\e[0;31m   [*******Ignore any 403 or 400 red error messages on the mining interface, as they are not errors**********]"
     echo -e "\e[0;32m   [*******Registration success will return Mining power=10, this is the initial reputation score  **********]"
     echo -e "\e[0;31m   [*******Registration failure in one case will return Mining power=0**********]"
     echo -e "\e[0;31m   [*******Failure to run in one case will return a 500 value**********]"
     read -p "Do you confirm to continue operation? Confirm by typing 'y': " confirm
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
        read -p "Please enter the number of GPUs currently installed on your machine: " gpus_num
        export gpus_num
        for i in $(seq 1 $gpus_num); do
            read -p "Please enter the sub-wallet address for the current $i-th card: " sub_wallet
            read -p "Please enter the master-wallet address for the current $i-th card: " master_wallet
            source ./nimenv_localminers/bin/activate
            (( x = $i-1))
            screen -dmS nim$i bash -c "CUDA_VISIBLE_DEVICES=$x make run addr=$sub_wallet master_wallet=$master_wallet"
            echo -e "\e[0;32m   [*******tom brother has successfully applied for the $i-th card, it has been switched to background running**********]"
            echo -e "\e[0;32m   [*******Please enter the command 'screen -r nim$i' to view the running status.**********]"
        done
        echo -e "\e[0;32m   [*******tom brother has successfully helped you with batch operations**********]"
        screen -ls
        echo -e "\e[0;32m   [*******tom brother reminds you of the operation results as shown above**********]"
        back_main_menu
    fi    
}

function start_with_old_gpus(){
    echo -e "\e[0;32m   [*******tom brother's gentle reminder**********]"
    echo -e "\e[0;31m   [*******Ignore any 403 or 400 red error messages on the mining interface, as they are not errors**********]"
    echo -e "\e[0;31m   [*******Ignore any 403 or 400 red error messages on the mining interface, as they are not errors**********]"
    echo -e "\e[0;31m   [*******Ignore any 403 or 400 red error messages on the mining interface, as they are not errors**********]"
    echo -e "\e[0;32m   [*******Running successfully will return Mining power greater than 10, which is the reputation score**********]"
    echo -e "\e[0;31m   [*******A failure case will return Mining power=0**********]"
    echo -e "\e[0;31m   [*******A failure case will return a 500 value**********]"
    echo -e "\e[0;31m   [*******A failure case will return 'Wallet xxx does not have master address', indicating no master wallet is bound**********]"
    read -p "Do you confirm to continue operation? Confirm by typing 'y': " confirm
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
        read -p "Please enter the number of GPUs currently installed on your machine: " gpus_num
        export gpus_num
        for i in $(seq 1 $gpus_num); do
            read -p "Please enter the sub-wallet address for the current $i-th card: " sub_wallet
            source ./nimenv_localminers/bin/activate
            (( x = $i-1))
            screen -dmS nim$i bash -c "CUDA_VISIBLE_DEVICES=$x make run addr=$sub_wallet"
            echo -e "\e[0;32m   [*******tom brother has successfully helped you run the $i-th card in the background**********]"
            echo -e "\e[0;32m   [*******Please enter the command 'screen -r nim$i' to view the running status.**********]"
        done
        echo -e "\e[0;32m   [*******tom brother has successfully helped you with batch operations**********]"
        screen -ls
        echo -e "\e[0;32m   [*******tom brother reminds you of the operation results as shown above**********]"
        back_main_menu
    fi    
}

function start_with_new_gpus_appoint(){
    echo -e "\e[0;32m   [*******tom brother's gentle reminder**********]"
    echo -e "\e[0;31m   [*******Please confirm that the current wallet registration is open**********]"
    echo -e "\e[0;31m   [*******Please confirm that the current wallet registration is open**********]"
    echo -e "\e[0;31m   [*******Please confirm that the current wallet registration is open**********]"
    echo -e "\e[0;31m   [*******Ignore any 403 or 400 red error messages on the mining interface, as they are not errors**********]"
    echo -e "\e[0;31m   [*******Ignore any 403 or 400 red error messages on the mining interface, as they are not errors**********]"
    echo -e "\e[0;31m   [*******Ignore any 403 or 400 red error messages on the mining interface, as they are not errors**********]"
    echo -e "\e[0;32m   [*******Registration success will return Mining power=10, which is the initial reputation score  **********]"
    echo -e "\e[0;31m   [*******Registration failure in one case will return Mining power=0**********]"
    echo -e "\e[0;31m   [*******Failure to run in one case will return a 500 value**********]"
    read -p "Do you confirm to continue operation? Confirm by typing 'y': " confirm
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
        read -p "Please enter the sequence number of the card you want to run (1, 2, 3, 4, ...): " gpus_no
        export gpus_no
        read -p "Please enter the sub-wallet address for the current $gpus_no-th card: " sub_wallet
        read -p "Please enter the master-wallet address for the current $gpus_no-th card: " master_wallet
        source ./nimenv_localminers/bin/activate
        (( x = $gpus_no-1))
        screen -dmS nim$gpus_no bash -c "CUDA_VISIBLE_DEVICES=$x make run addr=$sub_wallet master_wallet=$master_wallet"
        echo -e "\e[0;32m   [*******tom brother has successfully helped you with the $gpus_no-th card application, it has been switched to background running**********]"
        echo -e "\e[0;32m   [*******Please enter the command 'screen -r nim$gpus_no' to view the running status.**********]"
        echo -e "\e[0;32m   [*******tom brother has helped you with the operation successfully**********]"
        screen -ls
        echo -e "\e[0;32m   [*******tom brother reminds you of the operation results as shown above**********]"
        back_main_menu
    fi 
}

function start_with_old_gpus_appoint(){
    echo -e "\e[0;32m   [*******tom brother's gentle reminder**********]"
    echo -e "\e[0;31m   [*******Ignore any 403 or 400 red error messages on the mining interface, as they are not errors**********]"
    echo -e "\e[0;31m   [*******Ignore any 403 or 400 red error messages on the mining interface, as they are not errors**********]"
    echo -e "\e[0;31m   [*******Ignore any 403 or 400 red error messages on the mining interface, as they are not errors**********]"
    echo -e "\e[0;32m   [*******Running successfully will return Mining power greater than 10, which is the reputation score  **********]"
    echo -e "\e[0;31m   [*******A failure case will return Mining power=0**********]"
    echo -e "\e[0;31m   [*******A failure case will return a 500 value**********]"
    echo -e "\e[0;31m   [*******A failure case will return 'Wallet xxx does not have master address', indicating no master wallet is bound**********]"
    read -p "Do you confirm to continue operation? Confirm by typing 'y': " confirm
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
        read -p "Please enter the sequence number of the card you want to run (1, 2, 3, 4, ...): " gpus_no
        export gpus_no
        read -p "Please enter the sub-wallet address for the current $gpus_no-th card: " sub_wallet
        source ./nimenv_localminers/bin/activate
        (( x = $gpus_no-1))
        screen -dmS nim$gpus_no bash -c "CUDA_VISIBLE_DEVICES=$x make run addr=$sub_wallet"
        echo -e "\e[0;32m   [*******tom brother has successfully helped you with the $gpus_no-th card application, it has been switched to background running**********]"
        echo -e "\e[0;32m   [*******Please enter the command 'screen -r nim$gpus_no' to view the running status.**********]"
        echo -e "\e[0;32m   [*******tom brother has helped you with the operation successfully**********]"
        screen -ls
        echo -e "\e[0;32m   [*******tom brother reminds you of the operation results as shown above**********]"
        back_main_menu
    fi 
}

function show_status_multiple(){
    echo -e "\e[0;32m   [*******tom brother's gentle reminder**********]"
    echo -e "\e[0;31m   [*******Later, when you enter the mining interface, press ctrl+a+d for a safe exit operation**********]"
    echo -e "\e[0;31m   [*******Later, when you enter the mining interface, press ctrl+a+d for a safe exit operation**********]"
    echo -e "\e[0;31m   [*******Later, when you enter the mining interface, press ctrl+a+d for a safe exit operation**********]"
    echo -e "\e[0;31m   [*******Do not perform any other operations that might interrupt mining and cause loss of rewards**********]"
    read -p "Do you confirm you know how to operate? Confirm by typing 'y': " confirm
    export confirm
    if [ $confirm =  y ]; then
        read -p "Please enter the sequence number of the card you want to view the process for (1, 2, 3, 4, ...): " gpus_no
        screen -r nim$gpus_no
    else
        back_main_menu
    fi
}

function close_node_multiple(){
    echo -e "\e[0;32m   [*******tom brother's gentle reminder**********]"
    echo -e "\e[0;31m   [*******This operation will close all current mining processes**********]"
    echo -e "\e[0;31m   [*******This operation will close all current mining processes**********]"
    echo -e "\e[0;31m   [*******This operation will close all current mining processes**********]"
    echo -e "\e[0;31m   [*******This operation will close all current mining processes**********]"
    read -p "Do you confirm to continue operation? Confirm by typing 'y': " confirm
    export confirm
    if [ $confirm =  y ]; then
        read -p "Please enter the number of GPUs currently installed on your machine: " gpus_num
        for i in $(seq 1 $gpus_num); do
            screen -X -S nim$i quit
            echo -e "\e[0;32m   [*******tom brother has successfully helped you close the current mining process for the $i-th card**********]"
        done
        echo -e "\e[0;32m   [*******tom brother has successfully helped you with batch closing of current mining processes**********]"
        back_main_menu
    else
        back_main_menu
    fi
}

function close_node_appoint(){
    echo -e "\e[0;32m   [*******tom brother's gentle reminder**********]"
    echo -e "\e[0;31m   [*******This operation will close the mining process for the specified card**********]"
    echo -e "\e[0;31m   [*******This operation will close the mining process for the specified card**********]"
    echo -e "\e[0;31m   [*******This operation will close the mining process for the specified card**********]"
    echo -e "\e[0;31m   [*******This operation will close the mining process for the specified card**********]"
    read -p "Do you confirm to continue operation? Confirm by typing 'y': " confirm
    export confirm
    if [ $confirm =  y ]; then
        read -p "Please enter the sequence number of the card you want to close the mining process for (1, 2, 3, 4, ...): " gpus_no
        screen -X -S nim$gpus_no quit
        echo -e "\e[0;32m   [*******tom brother has successfully helped you close the current mining process for the $gpus_no-th card**********]"
        back_main_menu
    else
        back_main_menu
    fi
}

function close_node_appoint_new_restart(){
    echo -e "\e[0;32m   [*******tom brother's gentle reminder**********]"
    echo -e "\e[0;31m   [*******This operation will restart the mining process for the specified card in new wallet mode**********]"
    echo -e "\e[0;31m   [*******This operation will restart the mining process for the specified card in new wallet mode**********]"
    echo -e "\e[0;31m   [*******This operation will restart the mining process for the specified card in new wallet mode**********]"
    echo -e "\e[0;31m   [*******This operation will restart the mining process for the specified card in new wallet mode**********]"
    read -p "Do you confirm to continue operation? Confirm by typing 'y': " confirm
    export confirm
    if [ $confirm =  y ]; then
        read -p "Please enter the number of the card to restart (1, 2, 3, 4, ...): " gpus_no
        screen -X -S nim$gpus_no quit
        echo -e "\e[0;32m  【*******tom has helped you close the mining process for the current $gpus_no card**********】\e[0m"
        read -p "Please enter the current $gpus_no card's sub-wallet address: " sub_wallet
        read -p "Please enter the current $gpus_no card's master-wallet address: " master_wallet
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
        echo -e "\e[0;32m  【*******tom has helped you successfully apply for the current $gpus_no card, it has been converted to background running**********】\e[0m"
        back_main_menu
    else
        back_main_menu
    fi
}

function close_node_appoint_old_restart(){
    echo -e "\e[0;32m   [*******tom brother's gentle reminder**********]\e[0m"
    echo -e "\e[0;31m  【*******This operation will restart the mining process for the specified card in the old wallet/registered wallet mode**********】\e[0m"
    echo -e "\e[0;31m  【*******This operation will restart the mining process for the specified card in the old wallet/registered wallet mode**********】\e[0m"
    echo -e "\e[0;31m  【*******This operation will restart the mining process for the specified card in the old wallet/registered wallet mode**********】\e[0m"
    read -p "Is this operation confirmed? Confirm with 'y': " confirm
    export confirm
    if [ $confirm =  y ]; then
        read -p "Please enter the number of the card to restart (1, 2, 3, 4, ...): " gpus_no
        screen -X -S nim$gpus_no quit
        echo -e "\e[0;32m  【*******tom has helped you close the current $gpus_no card's mining process**********】\e[0m"
        read -p "Please enter the current $gpus_no card's sub-wallet address: " sub_wallet
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
        echo -e "\e[0;32m  【*******tom has helped you successfully run the current $gpus_tom in the background**********】\e[0m"
        back_main_menu
    else
        back_main_menu
    fi
}

function test_gpu(){
    nvidia-smi
    echo -e "\e[0;32m   [*******tom brother's gentle reminder**********]\e[0m"
    echo -e "\e[0;32m  If you encounter a 'command not found' error, it means the driver is not installed (for single card testing)   \e[0m"
    back_main_menu
}

function test_connection(){
    curl huggingface.co
    echo -e "\e[0;32m   [*******tom brother's gentle reminder**********]\e[0m"
    echo -e "\e[0;32m  Testing has ended, no return value indicates network issues   \e[0m"
    back_main_menu
}

function install_cuda(){
    echo -e "\e[0;32m   [*******tom brother's gentle reminder**********]\e[0m"
    echo -e "\e[0;32m  Driver installation address as follows, please download and install it yourself, recommend using the latest version for your specific GPU  \e[0m"
    echo -e "\e[0;31m https://developer.nvidia.com/cuda-toolkit-archive  \e[0m"
    echo -e "\e[0;32m Please note that Linux and WSL versions are different  \e[0m"
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
    echo -e "\e[0;32m   [*******tom's Gentle Reminder**********]\e[0m"
    echo -e "\e[0;32m   [*******Below are community-collected information, for reference only**********]\e[0m"
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
    echo -e "\e[0;32m   [*******tom's Gentle Reminder**********]\e[0m"
    echo -e "\e[0;31m   [*******This operation will delete the entire Nim program, please be cautious!**********]\e[0m"
    echo -e "\e[0;31m   [*******This operation will delete the entire Nim program, please be cautious!**********]\e[0m"
    echo -e "\e[0;31m   [*******This operation will delete the entire Nim program, please be cautious!**********]\e[0m"
    read -p "Is it confirmed? Please enter y if yes: " confirm
    if [ "$confirm" = y ]; then
            confirm_path
            echo "INFO=========================path:$path"
            echo "Goodbye, big brother"
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
    read -p "Input m to return to the main menu, input q to exit: " commond
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
  read -p "Please enter the mining child wallet address you want to query: " sub_wallet
  export sub_wallet
  read -p "Please enter the date you want to query, in the format (yyyy-MM-dd, reference 2024-07-22): " date
  export date
  echo -e "\e[0;32m  【*******tom's friendly reminder Query results as follows **********】\e[0m"
  echo 'Total tasks completed----------------------------'
  jq '.[] |  select(.WalletAddr | contains("'$sub_wallet'")) and  select(.CompletedTime | contains("'$date'")) ' my_logs.json  | wc -l
  echo 'Failure count--------------------------------'
  jq '.[] | select(.WalletAddr | contains("'$sub_wallet'"))  and  select(.CompletedTime | contains("'$date'")) and select(.Status | contains("Failed"))'  my_logs.json  | wc -l
  echo 'Success count---------------------------------'
  jq '.[] | select(.WalletAddr | contains("'$sub_wallet'"))  and  select(.CompletedTime | contains("'$date'")) and select(.Status | contains("Success"))'  my_logs.json  | wc -l
  echo 'Estimated income-----------------------------------'
  jq '.[] | select(.WalletAddr | contains("'$sub_wallet'"))  and  select(.CompletedTime | contains("'$date'")) and select(.Status | contains("Success"))'  my_logs.json  | wc -l
  echo -e "\e[0;32m  【*******tom's friendly reminder The above results are only a reference to local records and do not serve as any evidence. **********】\e[0m"
  back_main_menu
}

function main_menu_ch(){
    clear
    allConfirm=y
    echo "Please choose the operation to execute:"
    echo "===================================One-click mode series (suitable for beginners and new machines)================================================================="
    echo "1. One-click mining --Single card mode-- implies only one graphics card ) "
    echo "2. One-click mining --Multi-card mode-- implies having multiple graphics cards --2 card 8 card series, etc. ) "
    echo "====================================Regular installation mode===================================================================================="
    echo "3. Install the required dependencies environment  ) "
    echo "4. Install the wallet program  ) "
    echo "5. Install the mining program  ) "
    echo "6. One-click update mining program  ) "
    echo "======================================Common commands======================================================================================"
    echo "7. Bulk generate wallet addresses  ) "
    echo "8. Query the balance of the main wallet) "
    echo "9. View local upload logs  ) "
    echo "10. Query estimated earnings  ) "
    echo "===================================Quick start (environment already installed) single card================================================================="
    echo "11. Mine with a new wallet address -- suitable for unregistered wallet addresses  ) "
    echo "12. Mine with an old wallet address -- suitable for registered wallet addresses  ) "
    echo "13. View current nim process  ) "
    echo "14. Close nim process  ) "
    echo "===================================Quick start (environment already installed) multi-card================================================================="
    echo "15. Mine with a new wallet address -- multi-card mode -- suitable for unregistered wallet addresses -- batch mode  ) "
    echo "16. Mine with an old wallet address -- multi-card mode -- suitable for registered wallet addresses -- batch mode  ) "
    echo "17. Mine with a new wallet address -- multi-card mode -- suitable for unregistered wallet addresses -- specify a particular card  ) "
    echo "18. Mine with an old wallet address -- multi-card mode -- suitable for registered wallet addresses -- specify a particular card  ) "
    echo "19. View current multi-card nim process  ) "
    echo "20. Close multi-card nim process -- batch mode ) "
    echo "21. Close multi-card nim process -- specified mode ) "
    echo "22. Close multi-card nim process -- specified mode -- with re-start -- new wallet application ) "
    echo "23. Close multi-card nim process -- specified mode -- with re-start -- old wallet operation ) "
    echo "=================================================Auxiliary testing tools======================================================================="
    echo "24. Test graphics card driver ) "
    echo "25. Test connection to huggingface.co ) "
    echo "26. Install graphics card driver ) "
    echo "==================================================Suggestions and references========================================================================"
    echo "27. Related references and suggestions ) "
    echo "28. Reference power table ) "
    echo "==================================================Say Goodbye Series========================================================================"
    echo "29. Uninstall nimble mining "
    read -p "Please enter option (1-29): " OPTION
    case $OPTION in
    1) allConfirm=n && one_click_one_gpu ;;
    2) allConfirm=n && one_click_gpus ;;
    3) allConfirm=y && install_environments ;;
    4) allConfirm=y && install_wallet ;;
    5) allConfirm=y && install_nim ;;
    6) update_nim ;;
    7) allConfirm=y && create_wallet ;;
    8) check_balance ;;
    9) view_upload ;;
    10) query_estimated_revenue ;;
    11) allConfirm=y && start_with_new_one_gpu ;;
    12) allConfirm=y && start_with_old_one_gpu ;;
    13) show_status_one_gpu ;;
    14) close_node_one_gpu ;;
    15) start_with_new_gpus ;;
    16) start_with_old_gpus ;;
    17) start_with_new_gpus_appoint ;;
    18) start_with_old_gpus_appoint ;;
    19) show_status_multiple ;;
    20) close_node_multiple ;;
    21) close_node_appoint ;;
    22) close_node_appoint_new_restart ;;
    23) close_node_appoint_old_restart ;;
    24) test_gpu ;;
    25) test_connection ;;
    26) install_cuda ;;
    27) personal ;;
    28) computing_power_meter ;;
    29) uninstall_node ;;
    *) echo "Invalid option。" ;;
    esac
}

# 引导-ch
function guide_ch() {
    clear
    echo -e "\e[0;32m  【***************************Please read the following content carefully, it will be useful for project introduction and mining reminder****************************************】\e[0m"
    echo -e "\e[0;32m Kindly note that this program is suitable for the nim ubuntu tutorial, it is also applicable for windows down of wsl of ubuntu system. \e[0m"
    echo -e "\e[0;32m The project's prerequisite condition requires a CUDA-driven graphics card. Other than that, pure CPU or Mac series are not recommended for mining. The recommended model is 4090, which is the best, and other models provide a power table for viewing. \e[0m"
    echo -e "\e[0;32m The project introduction Nim is a real AI training project, which uses GPU to train models and upload training results to get related rewards.  \e[0m"
    echo -e "\e[0;32m NIM related models are connected to huggingface.co \e[0m"
    echo -e "\e[0;31m Regarding the miner's concern about earnings, the project is currently in the early stages, and the points obtained are one-to-one exchanged for mainnet tokens, so trading is not possible at this time. \e[0m"
    echo -e "\e[0;31m Regarding the project balance update mechanism, it is currently in an irregular update state, so balance queries have always been delayed. Please deeply understand this point. \e[0m"
    echo -e "\e[0;31m Regarding the mining process, NIM is in a task mechanism, which is to first accept a task, then train the task, and finally upload the training results. This is a complete process, repeated as such, a complete record goes through backend verification after which a token is given, so updates are not immediate. \e[0m"
    echo -e "\e[0;32m Regarding the mining process, common questions are as follows \e[0m"
    echo -e "\e[0;32m Question one: Mining interface initially often appears 403, 400 is this an error? \e[0m"
    echo -e "\e[0;31m Answer: This is not an error; it's normal. It's waiting for task reception. Please be patient, the waiting time varies, especially new wallets might have a particularly long waiting time. This is a normal phenomenon. \e[0m"
    echo -e "\e[0;32m Question two: How do I know if I am mining normally? \e[0m"
    echo -e "\e[0;31m Answer: If it's the first time mining on a machine, you will see a progress bar for model downloading. Then, the normal mining state will display the following content.  \e[0m"
    echo -e "\e[0;32m {‘loss’:0.xxxxx,'grad_norm':xxxxxxx............................}  \e[0m"
    echo -e "\e[0;32m {‘loss’:0.xxxxx,'grad_norm':xxxxxxx............................}  \e[0m"
    echo -e "\e[0;32m {‘loss’:0.xxxxx,'grad_norm':xxxxxxx............................}  \e[0m"
    echo -e "\e[0;32m Progress bar  xxx/ Task Packages Number    Time Elapsed/Estimated Remaining Time     Real-time Power it/s  \e[0m"
    echo -e "\e[0;32m Question three: What does the "Mining power" mean in the message returned after a 403 error? \e[0m"
    echo -e "\e[0;31m Answer: This value is the current reputation value of the credibility system. New wallets, after successful registration, will return 10 or 5 as long as it's not 0, which is considered normal. Old wallets currently have this value related to the balance. \e[0m"
    echo -e "\e[0;32m Question four: Is the "nvidia-smi: [errno 2]" line in white on the mining interface an error? \e[0m"
    echo -e "\e[0;31m Answer: This is not an error; it's normal. \e[0m"
    echo -e "\e[0;32m Question four: What does the green font line "Address:xxxxxxxxxxxxxxxxx executed the task" mean on the mining interface after running for a while? \e[0m"
    echo -e "\e[0;31m Answer: This indicates that a task has been completed, and then it will proceed to the upload operation. If the network is unstable, it will attempt five retries. If all attempts fail, it means the network is unstable, and the upload will not be successful, meaning this task is invalid. \e[0m"
    echo -e "\e[0;31m After this, it will continue to wait for tasks. Different wallet addresses have different waiting times, which is a normal phenomenon. Wait for the next task distribution. \e[0m"
    echo -e "\e[0;32m Question five: If I am a new wallet applicant, how do I know if my application has been successful? \e[0m"
    echo -e "\e[0;31m Answer: If the 403 response returns a Mining power of not 0, it is successful. A value of 0 indicates an invalid wallet. Change to a new wallet address and perform the wallet application registration operation after the wallet is open. \e[0m"
    echo -e "\e[0;32m Question six: Does this take up a lot of storage space? \e[0m"
    echo -e "\e[0;31m Answer: It does not occupy much space. The program includes automatic space verification and deletion of residual training results. On the mining interface, after uploading the training results, a few lines of red text "Deleted the model" will appear, indicating that operation. \e[0m"
    echo -e "\e[0;32m Question seven: What does it mean when running an old wallet address and it says "Wallet does not have master address"?  \e[0m"
    echo -e "\e[0;31m Answer: This means that you have run an incorrect command, and the registration was not successful. This address is invalid as it has not been bound to a main wallet. Please create a new wallet address and use the new wallet address mining feature for related new address application. \e[0m"
    echo -e "\e[0;32m Question eight: Why is the web-based balance query sometimes not working?  \e[0m"
    echo -e "\e[0;31m Answer: Web-based balance query is a community-created method for convenience. It's not official and not maintained by the official team. The official way to query balance is provided in this script. \e[0m"
    echo -e "\e[0;32m Question nine: If I have multiple GPUs, how should I configure the wallet?  \e[0m"
    echo -e "\e[0;31m Answer: Currently, the official method for new wallets is a one-to-one parent-child relationship. This means if you have multiple GPUs, you need to create multiple pairs of wallet addresses, which are nx2 wallet addresses. The binding relationship for old wallets is not subject to this restriction. This information was verified as of July 22, 2024. \e[0m"
    echo -e "\e[0;32m Question ten: Can I use one GPU to run multiple parent-child relationships or multiple GPUs to run a single parent-child wallet pair?  \e[0m"
    echo -e "\e[0;31m Answer: This method is strictly prohibited and will be considered cheating. You will not receive any rewards. Remember! \e[0m"
    echo -e "\e[0;32m Question eleven: If I haven't updated my balance for a while, is that normal, or is a new wallet balance of 0 normal?  \e[0m"
    echo -e "\e[0;31m Answer: The balance update system is inherently not timely, which is a normal phenomenon. Especially for new wallets, not updating is very normal. Please be patient. If you're really not confident, you can go to DC and get a ticket directly, no need to keep asking.  \e[0m"
    confirm_continue
}



function ask_question() {
    ###### 进行问答模式 避免相关人员不看操作 不尊重我的劳动成功
    question1
    question2
    question3
    question4
    question5
    question7
    question8
    question9
}

function question1() {
  echo -e "\e[0;32m Question: Can NIM be used for mining on a Mac or with a pure CPU? \e[0m"
  echo -e "\e[0;32m Option 1: Yes \e[0m"
  echo -e "\e[0;32m Option 2: Yes, but not recommended \e[0m"
  echo -e "\e[0;32m Option 3: No, but if you insist, it can be done \e[0m"
  read -p "Please enter the answer (number) " model
  if  [ "$model" -eq 2 ] || [ "$model" -eq 3 ]  ;then
     echo -e "\e[0;32m Answer correct \e[0m"
  else
    exit  0
  fi
}

function question2() {
  echo -e "\e[0;32m Question: If the mining interface shows "400 Service not available" is it an error? \e[0m"
  echo -e "\e[0;32m Option 1: Yes \e[0m"
  echo -e "\e[0;32m Option 2: No \e[0m"
  read -p "Please enter the answer (number): " model
  if  [ "$model" -eq 2 ]  ;then
     echo -e "\e[0;32m Answer correct \e[0m"
  else
    exit  0
  fi
}

function question3() {
  echo -e "\e[0;32m Question: What is NIM's balance update mechanism? \e[0m"
  echo -e "\e[0;32m Option 1: Not real-time \e[0m"
  echo -e "\e[0;32m Option 2: Real-time \e[0m"
  read -p "Please enter the answer (number): " model
  if  [ "$model" -eq 1 ]  ;then
     echo -e "\e[0;32m Answer correct \e[0m"
  else
    exit  0
  fi
}

function question4() {
  echo -e "\e[0;32m Question: Can I use one pair of wallet addresses for mining with multiple GPUs? \e[0m"
  echo -e "\e[0;32m Option 1: Yes \e[0m"
  echo -e "\e[0;32m Option 2: No \e[0m"
  read -p "Please enter the answer (number): " model
  if  [ "$model" -eq 2 ]  ;then
     echo -e "\e[0;32m Answer correct \e[0m"
  else
    exit  0
  fi
}

function question5() {
  echo -e "\e[0;32m Question: If I want to query the balance, what should I do? \e[0m"
  echo -e "\e[0;32m Option 1: Use the community-provided web-based balance query \e[0m"
  echo -e "\e[0;32m Option 2: Official command line balance query \e[0m"
  echo -e "\e[0;32m Option 3: Use the balance query feature in this script \e[0m"
  read -p "Please enter the answer (number): " model
  if  [ "$model" -eq 1 ] || [ "$model" -eq 2 ] || [ "$model" -eq 3 ]  ;then
     echo -e "\e[0;32m Answer correct \e[0m"
  else
    exit  0
  fi
}

function question7() {
  echo -e "\e[0;32m Question: Can AMD graphics cards be used for mining with this script? \e[0m"
  echo -e "\e[0;32m Option 1: Yes \e[0m"
  echo -e "\e[0;32m Option 2: No \e[0m"
  read -p "Please enter the answer (number): " model
  if  [ "$model" -eq 2 ]   ;then
     echo -e "\e[0;32m Answer correct \e[0m"
  else
    exit  0
  fi
}

function question8() {
    echo -e "\e[0;32m Question: How do I know if I am currently in a successful mining state? \e[0m"
    echo -e "\e[0;32m Option 1: New wallet application returns Mining power = 0 \e[0m"
    echo -e "\e[0;32m Option 2: New wallet application returns Mining power > 0 \e[0m"
    echo -e "\e[0;32m Option 3: Mining interface shows mining successful \e[0m"
    read -p "Please enter the answer (number): " model
    if  [ "$model" -eq 2 ]   ;then
       echo -e "\e[0;32m Answer correct \e[0m"
    else
      exit  0
    fi
}

function question9() {
    echo -e "\e[0;32m Question: I just used a new wallet for mining, and the balance query returned 0. Is this correct? \e[0m"
    echo -e "\e[0;32m Option 2: Incorrect \e[0m"
    echo -e "\e[0;32m Option 1: Correct \e[0m"
    read -p "Please enter the answer (number): " model
    if  [ "$model" -eq 1 ]   ;then
       echo -e "\e[0;32m Answer correct \e[0m"
    else
      exit  0
    fi
}

function congratulations() {
    echo -e "\e[0;32m Congratulations, you've reached the beginner level!！！！！！！！！！！！！ \e[0m"
    echo -e "\e[0;32m If you don't want to use the Q&A format next time, please use the following method to annotate the code \e[0m"
    echo -e "\e[0;31m Edit the Nimble.sh file, and comment out the ask_question congratulations method at the end.  \e[0m"
}

function confirm_continue(){
  read -p "Please confirm that you have read and understood the above content, and confirm by entering y. " contine
  export contine
  if [ $contine = y ]; then
     echo -e "\e[0;32m  【*******Thank you for understanding, proceeding to the next step.**********】\e[0m"
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
#### i am  here
#ask_question
#congratulations
#### end
main_menu_ch





