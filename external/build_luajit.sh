#!/bin/bash

echo "$0 $1 $2 $3 $4 $5"
echo "HOST_CC=cc $4"

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
EXTRA=""

if [ ! -d ${DIR}/LuaJIT-2.0.4 ]; then
	wget "http://luajit.org/download/LuaJIT-2.0.4.tar.gz" -O ${DIR}/LuaJIT-2.0.4.tar.gz
	tar xf ${DIR}/LuaJIT-2.0.4.tar.gz -C ${DIR}
# 	rm ${DIR}/LuaJIT-2.0.4.tar.gz
fi

if [[ $2 == *"mingw"* ]]; then
	EXTRA="TARGET_SYS=Windows";
fi

if [ ! -f $1/libluajit_static.a ]; then
	echo "make clean libluajit.a -C ${DIR}/LuaJIT-2.0.4/src HOST_CC=\"cc $5\" BUILDMODE=static CC=\"$2\" ASM=\"$3\" STRIP=$4 $EXTRA"
	make clean libluajit.a -C ${DIR}/LuaJIT-2.0.4/src HOST_CC="cc $5" BUILDMODE=static CC="$2" ASM="$3" STRIP=$4 $EXTRA
	cp ${DIR}/LuaJIT-2.0.4/src/libluajit.a libluajit_static.a
fi
