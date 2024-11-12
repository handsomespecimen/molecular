#!/bin/bash
# Installing dependencies needed to build CemicalFun on (k)ubuntu linux 20.04 or macOS

# Temporarily uncomment rows for packages that need to be re-installed
#sudo rm -rf /usr/local/include/nlohmann
#sudo rm -rf /usr/local/include/eigen3/Eigen/Eigen
#sudo rm -rf /usr/local/include/pybind11
#sudo rm -rf /usr/local/include/spdlog

# nlohmann/json library v. 3.6.1 or up
# if not installed in /usr/local/include/nlohmann)
test -f /usr/local/include/nlohmann/json.hpp || {

	# Getting nlohmann/json library
	mkdir -p ~/code && \
		cd ~/code && \
		git clone https://github.com/nlohmann/json.git && \
		cd json && \
		mkdir -p build && \
		cd build && \
		cmake .. -DCMAKE_BUILD_TYPE=Release -DJSON_BuildTests=OFF -DJSON_MultipleHeaders=ON && \
		sudo make install

	# Removing generated build files
	cd ~ && \
		 rm -rf ~/code
}

# Eigen3 math library (added for building and installing xGEMS)
# if not installed in /usr/local/include/eigen3)
test -d /usr/local/include/eigen3/Eigen || {

        # Building eigen library
        mkdir -p ~/code && \
                cd ~/code && \
                git clone https://gitlab.com/libeigen/eigen.git -b 3.4.0 && \
                cd eigen && \
                mkdir -p build && \
                cd build && \
                cmake .. \
                make && \
                sudo make install

        # Removing generated build files
        cd ~ && \
                 rm -rf ~/code
}

# spdlog 
# if no spdlog installed in /usr/local/include/spdlog (copy only headers)
test -d /usr/local/include/spdlog || {

        # Building spdlog library
        mkdir -p ~/code && \
                cd ~/code && \
                git clone https://github.com/gabime/spdlog -b v1.11.0  && \
                cd spdlog/include && \
                sudo cp -r spdlog /usr/local/include

        # Removing generated build files
        cd ~ && \
                 rm -rf ~/code
}

#Pybind11
test -d /usr/local/include/pybind11 || {

        # Building pybind11 library
	mkdir -p ~/code && \
		cd ~/code && \
		git clone https://github.com/pybind/pybind11.git && \
		cd pybind11 && \
		mkdir -p build && \
		cd build && \
		cmake .. -DPYBIND11_TEST=OFF && \
		make && \
		sudo make install

	# Removing generated build files
	cd ~ && \
		 rm -rf ~/code
}

if [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
   sudo ldconfig
fi
