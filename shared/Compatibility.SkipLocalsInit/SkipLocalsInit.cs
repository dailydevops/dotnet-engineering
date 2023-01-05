#if NET5_0_OR_GREATER
#elif NET47 || NET471 || NET472 || NET48 || NETFRAMEWORK || NETCOREAPP2_0 || NETCOREAPP2_1 || NETCOREAPP2_2 || NETCOREAPP3_0 || NETCOREAPP3_1 || NETSTANDARD2_0 || NETSTANDARD2_1 || NETSTANDARD
namespace System.Runtime.CompilerServices;

[AttributeUsage(AttributeTargets.Module
    | AttributeTargets.Class
    | AttributeTargets.Struct
    | AttributeTargets.Interface
    | AttributeTargets.Constructor
    | AttributeTargets.Method
    | AttributeTargets.Property
    | AttributeTargets.Event, Inherited = false)]
internal sealed class SkipLocalsInitAttribute : Attribute
{
    public SkipLocalsInitAttribute()
    {
    }
}
#else
#error Platform not supported
#endif
