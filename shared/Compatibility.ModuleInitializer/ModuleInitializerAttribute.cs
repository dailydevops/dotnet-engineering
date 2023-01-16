#if NET5_0 || NET6_0 || NET7_0
#elif NET47 || NET471 || NET472 || NET48 || NETFRAMEWORK || NETCOREAPP2_0 || NETCOREAPP2_1 || NETCOREAPP2_2 || NETCOREAPP3_0 || NETCOREAPP3_1 || NETSTANDARD2_0 || NETSTANDARD2_1
namespace System.Runtime.CompilerServices;

using System.Diagnostics.CodeAnalysis;


/// <summary>
/// Used to indicate to the compiler that a method should be called
/// in its containing module's initializer.
/// </summary>
/// <remarks>
/// When one or more valid methods
/// with this attribute are found in a compilation, the compiler will
/// emit a module initializer which calls each of the attributed methods.
///
/// Certain requirements are imposed on any method targeted with this attribute:
/// - The method must be `static`.
/// - The method must be an ordinary member method, as opposed to a property accessor, constructor, local function, etc.
/// - The method must be parameterless.
/// - The method must return `void`.
/// - The method must not be generic or be contained in a generic type.
/// - The method's effective accessibility must be `internal` or `public`.
///
/// The specification for module initializers in the .NET runtime can be found here:
/// https://github.com/dotnet/runtime/blob/main/docs/design/specs/Ecma-335-Augments.md#module-initializer
/// </remarks>
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
