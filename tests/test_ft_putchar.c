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
    const char *output = cr_get_redirected_stdout();
    cr_assert_str_eq(output, "\n", "Expected '\\n' but got '%s'", output);
}

Test(ft_putchar, test_tab, .init = redirect_stdout)
{
    ft_putchar('\t');
    const char *output = cr_get_redirected_stdout();
    cr_assert_str_eq(output, "\t", "Expected '\\t' but got '%s'", output);
}

Test(ft_putchar, test_null, .init = redirect_stdout)
{
    ft_putchar('\0');
    const char *output = cr_get_redirected_stdout();
    cr_assert_str_eq(output, "\0", "Expected '\\0' but got '%s'", output);
}

Test(ft_putchar, test_ff, .init = redirect_stdout)
{
    ft_putchar('\xFF');
    const char *output = cr_get_redirected_stdout();
    cr_assert_str_eq(output, "\xFF", "Expected '\\xFF' but got '%s'", output);
}