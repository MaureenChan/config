# Ruby
export PATH="/usr/local/opt/ruby/bin:$PATH"

#Alias
alias md="/usr/bin/memcached -m 64 -p 11211 -l 127.0.0.1 -d"
alias ds="dscacheutil -flushcache"
alias vi="vim"
alias py="python"
alias proxy="python /Users/Maureen/Proxy/shsock_daemon.py start"
alias ls="ls -G"
alias ll="ls -a -l"
alias cxx="clang++ -std=c++11 -stdlib=libc++ -Weverything -Wno-c++98-compat"

# PAC 
function refresh_pac_proxy() {
  export OLD_IFS=$IFS
  export IFS=$'\n'
  export PAC='file://localhost/Users/Maureen/Proxy/autoproxy.pac'
  export Services=('USB Ethernet' 'Wi-Fi')
  for network in ${Services[@]}
  do
      `sudo networksetup -setautoproxystate "$network" off`
      `sudo networksetup -setautoproxyurl "$network" "$PAC"`
      `sudo networksetup -setautoproxystate "$network" on`
      echo $network
  done
  export IFS=$OLD_IFS
}
alias rpx="refresh_pac_proxy"

export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/bin:$PATH

source /usr/local/etc/bash_completion

# JAVA
export JAVA_HOME=`/usr/libexec/java_home -v 1.8`
export PATH=${JAVA_HOME}/bin:$PATH

export CATALINA_BASE="/usr/local/Cellar/tomcat/8.0.15/libexec"
export CATALINA_HOME="/usr/local/Cellar/tomcat/8.0.15/libexec"

# JBOSS
export JBOSS_HOME="/usr/local/Cellar/jboss-as/7.1.1.Final/libexec"
export PATH=${JBOSS_HOME}/bin:$PATH

# PHP
export PATH=/usr/local/php5/bin:$PATH
export PATH=/usr/local/sbin:$PATH
