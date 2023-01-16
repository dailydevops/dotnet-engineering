#if NET5_0 || NET6_0 || NET7_0
#elif NET47 || NET471 || NET472 || NET48 || NETFRAMEWORK || NETCOREAPP2_0 || NETCOREAPP2_1 || NETCOREAPP2_2 || NETCOREAPP3_0 || NETCOREAPP3_1 || NETSTANDARD2_0 || NETSTANDARD2_1
namespace System.Runtime.CompilerServices;

using System.Diagnostics.CodeAnalysis;

//
// Summary:
//     Used to indicate to the compiler that a method should be called in its containing
//     module's initializer.
[AttributeUsage(AttributeTargets.Method, Inherited = false)]
[ExcludeFromCodeCoverage]
[CompilerGenerated]
internal sealed class ModuleInitializerAttribute : Attribute
{
    //
    // Summary:
    //     Initializes a new instance of the System.Runtime.CompilerServices.ModuleInitializerAttribute
    //     class.
    public ModuleInitializerAttribute() { }
}
#else
#error Platform not supported
#endif
