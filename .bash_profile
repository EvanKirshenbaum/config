# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs

PATH=/usr/local/bin:/usr/bin:/cygdrive/c/Windows/System32
#PATH=/opt/jdk/jdk1.8.0_25/bin:/usr/local/gcc-7.2.0/bin:$PATH:$HOME/bin
#PATH=/opt/jdk/jdk1.8.0_25/bin:/usr/local/gcc-7.3.0/bin:$PATH:$HOME/bin
PATH=$PATH:$HOME/bin

export PATH
