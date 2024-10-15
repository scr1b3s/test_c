# Compiler and flags
CC = gcc
CFLAGS = -Wall -Wextra -g
LIBS = -lcriterion  # Link with Criterion

# Directories
SRC_DIR = src
TEST_DIR = tests

# Find all .c files in src/ directory
SRC_FILES := $(shell find $(SRC_DIR) -name "*.c")

# Find all test_*.c files in tests/ directory
TEST_FILES := $(shell find $(TEST_DIR) -name "test_*.c")

# Extract base names of source files (e.g., src/ft_strstr.c -> ft_strstr)
SRC_BASES := $(basename $(notdir $(SRC_FILES)))

# Extract base names of test files (e.g., tests/test_ft_strstr.c -> ft_strstr)
TEST_BASES := $(patsubst test_%, %, $(basename $(notdir $(TEST_FILES))))

# Match only sources that have corresponding test files
MATCHED_SRCS := $(filter $(addprefix %, $(TEST_BASES)), $(SRC_BASES))

# Full paths of the matched source files
MATCHED_SRC_FILES := $(addprefix $(SRC_DIR)/, $(addsuffix .c, $(MATCHED_SRCS)))

# Object files generated from the matched source files
OBJ_FILES := $(patsubst $(SRC_DIR)/%.c, $(SRC_DIR)/%.o, $(MATCHED_SRC_FILES))

# Create corresponding test binaries (one per matched source file)
TEST_BINARIES := $(patsubst $(SRC_DIR)/%.c, $(TEST_DIR)/test_%, $(MATCHED_SRC_FILES))

# Default target: build all test binaries
all: $(TEST_BINARIES)

# Rule to create object files from matched source files
$(SRC_DIR)/%.o: $(SRC_DIR)/%.c
	$(CC) $(CFLAGS) -c -o $@ $<

# Rule to build each individual test binary only if the test file exists
$(TEST_DIR)/test_%: $(SRC_DIR)/%.o
	@if [ -f $(TEST_DIR)/test_$*.c ]; then \
		echo "Building test_$*..."; \
		$(CC) $(CFLAGS) -o $@ $(SRC_DIR)/$*.o $(TEST_DIR)/test_$*.c $(LIBS); \
	else \
		echo "Skipping test_$* (test file not found)"; \
	fi

# Clean up object files and test binaries
clean:
	rm -f $(SRC_DIR)/*.o $(TEST_BINARIES)
