## shortcuts to other machines
alias murray='ssh weiyi@murray'
alias nile='ssh weiyi@nile'
alias niles='ssh weiyi@nile-stage'
alias orinoco='ssh weiyi@orinoco'
alias orinocos='ssh weiyi@orinoco-stage'
alias beni='ssh root@beni'
alias feni='ssh root@feni'
alias kwai='ssh weiyi@kwai'
alias dev5='ssh root@dev5'
alias danshui='ssh weiyi@danshui'
alias elrond='ssh weiyi@elrond'
alias samwise='ssh weiyi@samwise'
alias blackomelette='ssh cinaeco@10.0.1.20'
alias pavo='ssh cinaeco@pavo'
alias ursa='ssh cinaeco@ursa'
alias fornax='ssh administrator@fornax'

## shortcuts for development
alias authlog='tail -F /jails/alcatraz/usr/local/www-conf/logs/auth-phplog'
alias deliverylog='tail -F /jails/alcatraz/usr/local/www-conf/logs/delivery-phplog'
alias oarslog='tail -F /jails/alcatraz/usr/local/www-conf/logs/oars-phplog'
alias schoolslog='tail -F /jails/alcatraz/usr/local/www-conf/logs/schools-phplog'
alias cda='cd /jails/alcatraz/usr/local/www/auth'
alias cdd='cd /jails/alcatraz/usr/local/www/delivery'
alias cdo='cd /jails/alcatraz/usr/local/www/oars'
alias cds='cd /jails/alcatraz/usr/local/www/schools'
alias migrate='li3 migration db:migrate'
alias sqlo='mysql -u oars -p'

## proxy setup
alias proxy='export http_proxy=http://192.168.1.248:3128;export HTTP_PROXY=$http_proxy;export https_proxy=$http_proxy;export HTTPS_PROXY=$http_proxy;export ftp_proxy=$http_proxy;export FTP_PROXY=$http_proxy;'
alias noproxy='export http_proxy='';export HTTP_PROXY=$http_proxy;export https_proxy=$http_proxy;export HTTPS_PROXY=$http_proxy;export ftp_proxy=$http_proxy;export FTP_PROXY=$http_proxy;'

## shortcuts for Jails setup
#alias guantanamo-start='env -i /usr/sbin/chroot /jails/guantanamo /usr/local/apache2/bin/httpd -k start'
#alias guantanamo-graceful='env -i /usr/sbin/chroot /jails/guantanamo /usr/local/apache2/bin/httpd -k graceful'
#alias guantanamo-stop='env -i /usr/sbin/chroot /jails/guantanamo /usr/local/apache2/bin/httpd -k stop'
#alias guantanamo-check='chroot /jails/guantanamo /usr/local/apache2/bin/apachectl -t'

#alias woomera-start='env -i /usr/sbin/chroot /jails/woomera /usr/local/apache2/bin/httpd -k start'
#alias woomera-graceful='env -i /usr/sbin/chroot /jails/woomera /usr/local/apache2/bin/httpd -k graceful'
#alias woomera-stop='env -i /usr/sbin/chroot /jails/woomera /usr/local/apache2/bin/httpd -k stop'
#alias woomera-check='chroot /jails/woomera /usr/local/apache2/bin/apachectl -t'

#alias littlehey-start='env -i /usr/sbin/chroot /jails/littlehey /usr/local/apache2/bin/httpd -k start'
#alias littlehey-graceful='env -i /usr/sbin/chroot /jails/littlehey /usr/local/apache2/bin/httpd -k graceful'
#alias littlehey-stop='env -i /usr/sbin/chroot /jails/littlehey /usr/local/apache2/bin/httpd -k stop'
#alias littlehey-check='chroot /jails/littlehey /usr/local/apache2/bin/apachectl -t'

#alias alcatraz-start='env -i /usr/sbin/chroot /jails/alcatraz /usr/local/apache2/bin/httpd -k start'
#alias alcatraz-graceful='env -i /usr/sbin/chroot /jails/alcatraz /usr/local/apache2/bin/httpd -k graceful'
#alias alcatraz-stop='env -i /usr/sbin/chroot /jails/alcatraz /usr/local/apache2/bin/httpd -k stop'
#alias alcatraz-check='chroot /jails/alcatraz /usr/local/apache2/bin/apachectl -t'

#alias kerobokan-start='env -i /usr/sbin/chroot /jails/kerobokan /usr/local/apache2/bin/httpd -k start'
#alias kerobokan-graceful='env -i /usr/sbin/chroot /jails/kerobokan /usr/local/apache2/bin/httpd -k graceful'
#alias kerobokan-stop='env -i /usr/sbin/chroot /jails/kerobokan /usr/local/apache2/bin/httpd -k stop'
#alias kerobokan-check='chroot /jails/kerobokan /usr/local/apache2/bin/apachectl -t'

#alias changi-start='/etc/init.d/tc-chroot start'
#alias changi-stop='/etc/init.d/tc-chroot stop'