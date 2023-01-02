#if NETSTANDARD2_0 || NETSTANDARD2_1
namespace System.Runtime.CompilerServices;

using System.Diagnostics.CodeAnalysis;

//
// Summary:
//     Used to indicate to the compiler that a method should be called in its containing
//     module's initializer.
[AttributeUsage(AttributeTargets.Method, Inherited = false)]
[ExcludeFromCodeCoverage]
public sealed class ModuleInitializerAttribute : Attribute
{
  //
  // Summary:
  //     Initializes a new instance of the System.Runtime.CompilerServices.ModuleInitializerAttribute
  //     class.
  public ModuleInitializerAttribute() { }
}
#endif
