#add-auto-load-safe-path /usr/local/lib64/libstdc++.so.6.0.20-gdb.py
#add-auto-load-safe-path /usr/local/gcc-4.9.2/lib64/libstdc++.so.6.0.20-gdb.py
#set args -classpath ".:../../bin:../../../../java-api/external/log4j-1.2.15.jar:../../../../java-api/external/ErkUtils.jar:../../../../java-api/external/commons-compress-1.1.jar:../../../../java-api/bin" -Djava.library.path=../../../../java-api/LinuxDebug com.hpl.inventory.Demo3_Shop -nthreads=1
#break ../../core/include/core/core_msv.h:862

# set args -classpath ".:../../bin:../../../../java-api/external/log4j-1.2.15.jar:../../../../java-api/external/ErkUtils.jar:../../../../java-api/external/commons-compress-1.1.jar:../../../../java-api/bin" -Djava.library.path=../../../../java-api/LinuxDebug Create

set non-stop off
set print static-members off
