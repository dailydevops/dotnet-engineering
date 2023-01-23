#if NET5_0_OR_GREATER
#elif NET47 || NET471 || NET472 || NET48 || NETFRAMEWORK || NETCOREAPP2_0 || NETCOREAPP2_1 || NETCOREAPP2_2 || NETCOREAPP3_0 || NETCOREAPP3_1 || NETSTANDARD2_0 || NETSTANDARD2_1 || NETSTANDARD
// Licensed to the .NET Foundation under one or more agreements.
// The .NET Foundation licenses this file to you under the MIT license.
namespace System.Runtime.CompilerServices;

using System.Diagnostics.CodeAnalysis;

/// <summary>
/// Used to indicate to the compiler that the <c>.locals init</c> flag should not be set in method headers.
/// </summary>
[AttributeUsage(
    AttributeTargets.Module
        | AttributeTargets.Class
        | AttributeTargets.Struct
        | AttributeTargets.Interface
        | AttributeTargets.Constructor
        | AttributeTargets.Method
        | AttributeTargets.Property
        | AttributeTargets.Event,
    Inherited = false
)]
[ExcludeFromCodeCoverage]
[CompilerGenerated]
internal sealed class SkipLocalsInitAttribute : Attribute
{
    public SkipLocalsInitAttribute() { }
}
#else
#error Platform not supported
#endif
