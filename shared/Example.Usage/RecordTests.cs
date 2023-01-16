namespace Example.Usage;

using System.Diagnostics.CodeAnalysis;
using System.Diagnostics;
using System.Threading.Tasks;
using System.Runtime.CompilerServices;

[ExcludeFromCodeCoverage]
[CompilerGenerated]
[StackTraceHidden]
public static class RecordTests
{
    public static string Cut(this string value)
    {
        var result = value;

        return result[1..];
    }

    public static async Task<string> Test(this string value)
    {
        await Task.Yield();
        return value;
    }
}
