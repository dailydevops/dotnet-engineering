#if NET5_0_OR_GREATER
#elif NETFRAMEWORK || NETSTANDARD || NETCOREAPP
namespace System.Runtime.CompilerServices;

using System.Diagnostics.CodeAnalysis;

[ExcludeFromCodeCoverage]
[CompilerGenerated]
internal static class IsExternalInit { }
#else
#error Platform not supported
#endif
