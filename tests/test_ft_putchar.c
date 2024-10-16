#include <criterion/criterion.h>
#include <criterion/redirect.h>
#include <unistd.h>
#include <fcntl.h>
#include <string.h>

void	ft_putchar(char c);

// Helper function to capture stdout
void redirect_stdout(void)
{
    cr_redirect_stdout();
}

Test(ft_putchar, test_newline, .init = redirect_stdout)
{
    ft_putchar('\n');
    cr_assert_stdout_eq_str("\n", "Expected '\\n' but got different output");
}

Test(ft_putchar, test_tab, .init = redirect_stdout)
{
    ft_putchar('\t');
    cr_assert_stdout_eq_str("\t", "Expected '\\t' but got different output");
}

Test(ft_putchar, test_null, .init = redirect_stdout)
{
    ft_putchar('\0');
    cr_assert_stdout_eq_str("\0", "Expected '\\0' but got different output");
}

Test(ft_putchar, test_ff, .init = redirect_stdout)
{
    ft_putchar('\xFF');
    cr_assert_stdout_eq_str("\xFF", "Expected '\\xFF' but got different output");
}

// Add more test cases here as needed