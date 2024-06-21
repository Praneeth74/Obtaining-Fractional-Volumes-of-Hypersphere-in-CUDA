# Compiler
CXX = g++
NVCC = nvcc

# Compiler flags
CXXFLAGS = -Wall -Wextra -std=c++11
NVCCFLAGS = -arch=sm_61

# Targets
TARGET_CPU = ball_samp-cpu
TARGET_CUDA = ball_samp-cuda

# Source files
SRCS_CPP = ball_samp-cpu.cpp
SRCS_CUDA = ball_samp-cuda.cu

# Object files
OBJS_CPP = $(SRCS_CPP:.cpp=.o)
OBJS_CUDA = $(SRCS_CUDA:.cu=.o)

# CUDA Compilation rule
%.o: %.cu
	$(NVCC) $(NVCCFLAGS) -c $< -o $@

# Compilation rule
%.o: %.cpp
	$(CXX) $(CXXFLAGS) -c $< -o $@

# Linking rule for CPU executable
$(TARGET_CPU): $(OBJS_CPP)
	$(CXX) $(CXXFLAGS) $(OBJS_CPP) -o $@

# Linking rule for CUDA executable
$(TARGET_CUDA): $(OBJS_CUDA)
	$(NVCC) $(NVCCFLAGS) $(OBJS_CUDA) -o $@

# Default target (compile both versions)
all: $(TARGET_CPU) $(TARGET_CUDA)

# Clean rule
clean:
	rm -f $(OBJS_CPP) $(OBJS_CUDA) $(TARGET_CPU) $(TARGET_CUDA)

# Phony targets
.PHONY: all clean

