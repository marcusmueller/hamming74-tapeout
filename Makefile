WOKWI_PROJECT_ID=hamming74
# logic puzzle and muxes
# 4 inverters 334348818476696146
# the clock divider 334335179919196756
fetch:
	# curl https://wokwi.com/api/projects/$(WOKWI_PROJECT_ID)/verilog > src/user_module_$(WOKWI_PROJECT_ID).v
	sed -e 's/USER_MODULE_ID/$(WOKWI_PROJECT_ID)/g' template/scan_wrapper.v > src/scan_wrapper_$(WOKWI_PROJECT_ID).v
	sed -e 's/USER_MODULE_ID/$(WOKWI_PROJECT_ID)/g' template/config.tcl > src/config.tcl
	echo $(WOKWI_PROJECT_ID) > src/ID

# needs PDK_ROOT and OPENLANE_ROOT, OPENLANE_IMAGE_NAME set from your environment
harden:
	docker run --rm \
	-v $(OPENLANE_ROOT):/openlane \
	-v $(PDK_ROOT):$(PDK_ROOT) \
	-v $(CURDIR):/work \
	-e PDK_ROOT=$(PDK_ROOT) \
	-u $(shell id -u $(USER)):$(shell id -g $(USER)) \
	$(OPENLANE_IMAGE_NAME) \
	/bin/bash -c "./flow.tcl -overwrite -design /work/src -run_path /work/runs -tag wokwi"

simulation: src/hamming74_top.cc src/simulation.cc
	$(CXX) -std=c++20 \
         -Wall -Wpedantic \
         -I `yosys-config --datdir`/include -I /usr/include/yosys \
         -o simulation \
         -lfmt \
         src/simulation.cc

src/hamming74_top.cc: src/user_module_hamming74.v
	echo "read_verilog src/user_module_hamming74.v; write_cxxrtl src/hamming74_top.cc" | yosys

simulate: simulation
	./simulation
.PHONY: simulate
