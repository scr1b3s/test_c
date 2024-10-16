#include <criterion/criterion.h>
#include <criterion/redirect.h>
#include <string.h>
#include "../src/ft_putchar.c"

// Helper function to capture stdout
void redirect_stdout(void)
{
    cr_redirect_stdout();
}

Test(ft_putchar, test_newline, .init = redirect_stdout)
{
    ft_putchar('\n');
    fflush(stdout);
    FILE *output = cr_get_redirected_stdout();
    char buffer[2];
    fgets(buffer, sizeof(buffer), output);
    cr_assert_str_eq(buffer, "\n", "Expected '\\n' but got '%s'", buffer);
}

Test(ft_putchar, test_tab, .init = redirect_stdout)
{
    ft_putchar('\t');
    fflush(stdout);
    FILE *output = cr_get_redirected_stdout();
    char buffer[2];
    fgets(buffer, sizeof(buffer), output);
    cr_assert_str_eq(buffer, "\t", "Expected '\\t' but got '%s'", buffer);
}

Test(ft_putchar, test_null, .init = redirect_stdout)
{
    ft_putchar('\0');
    fflush(stdout);
    FILE *output = cr_get_redirected_stdout();
    char buffer[2];
    fgets(buffer, sizeof(buffer), output);
    cr_assert_str_eq(buffer, "\0", "Expected '\\0' but got '%s'", buffer);
}

Test(ft_putchar, test_ff, .init = redirect_stdout)
{
    ft_putchar('\xFF');
    fflush(stdout);
    FILE *output = cr_get_redirected_stdout();
    char buffer[2];
    fgets(buffer, sizeof(buffer), output);
    cr_assert_str_eq(buffer, "\xFF", "Expected '\\xFF' but got '%s'", buffer);
}