namespace Example.Usage;

using System.Diagnostics;
using System.Diagnostics.CodeAnalysis;
using System.Runtime.CompilerServices;

[ExcludeFromCodeCoverage]
[StackTraceHidden]
public static class ClassWithStringSyntax
{
    public static bool Validate(
        [StringSyntax(StringSyntaxAttribute.Json)] string value,
        [CallerArgumentExpression(nameof(value))] string? _ = null
    ) => !string.IsNullOrEmpty(value);
}
