# Compiler and flags
CC = gcc
CFLAGS = -Wall -Wextra -g
LIBS = -lcriterion  # Link with Criterion

# Directories
SRC_DIR = src
TEST_DIR = tests

# Find all .c files in the src/ directory
SRC_FILES := $(shell find $(SRC_DIR) -name "*.c")

# Object files generated from the source files
OBJ_FILES := $(patsubst $(SRC_DIR)/%.c, $(SRC_DIR)/%.o, $(SRC_FILES))

# Create corresponding test binaries (one per source file)
TEST_BINARIES := $(patsubst $(SRC_DIR)/%.c, $(TEST_DIR)/test_%, $(SRC_FILES))

# Default target: build all test binaries
all: $(TEST_BINARIES)

# Rule to create object files from source files
$(SRC_DIR)/%.o: $(SRC_DIR)/%.c
	$(CC) $(CFLAGS) -c -o $@ $<

# Rule to build each individual test binary
$(TEST_DIR)/test_%: $(SRC_DIR)/%.o $(TEST_DIR)/test_%.c
	$(CC) $(CFLAGS) -o $@ $^ $(LIBS)

# Clean rule to remove generated binaries and object files
clean:
	rm -f $(TEST_BINARIES) $(OBJ_FILES)

.PHONY: all clean
