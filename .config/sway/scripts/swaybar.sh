bt=$(acpi | grep -oe '[0-9]\{1,3\}%')
dt=$(date +'%Y-%m-%d %X')
echo "${dt}   ${bt} "
