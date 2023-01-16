namespace Example.Usage;

using System;
using System.Diagnostics;
using System.Diagnostics.CodeAnalysis;
using System.Runtime.CompilerServices;

[ExcludeFromCodeCoverage]
[CompilerGenerated]
[StackTraceHidden]
internal sealed class ProgramWithModuleInitializer
{
    private static void Main(string[] _) => Console.WriteLine(Name);

    public static string Name { get; set; } = default!;

    [ModuleInitializer]
    public static void Init() => Name = "NetEvolve";
}
