#if NET5_0_OR_GREATER
#elif NET461 || NET472 || NETSTANDARD2_0 || NETSTANDARD2_1 || NETCOREAPP3_1
namespace System.Diagnostics.CodeAnalysis;
namespace System.Runtime.CompilerServices;

[ExcludeFromCodeCoverage]
internal static class IsExternalInit { }
#else
#error Platform not supported
#endif
