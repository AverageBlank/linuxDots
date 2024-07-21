if cat /proc/cpuinfo | grep hypervisor; then
    nitrogen --random --set-zoom-fill ~/wallpapers &
else
    nitrogen --head=1 --random --set-zoom-fill ~/wallpapers &
    sleep 2
    nitrogen --head=2 --random --set-zoom-fill ~/wallpapers &
fi
