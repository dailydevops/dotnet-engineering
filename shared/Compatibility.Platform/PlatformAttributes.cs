#if NET5_0_OR_GREATER || DISABLE_SUPPORT_PLATFORM
#elif NET47_OR_GREATER || NETSTANDARD2_0_OR_GREATER || NETCOREAPP3_0_OR_GREATER
// Licensed to the .NET Foundation under one or more agreements.
// The .NET Foundation licenses this file to you under the MIT license.

#nullable enable
#pragma warning disable
namespace System.Runtime.Versioning
{
    using System.Diagnostics.CodeAnalysis;

    /// <summary>
    /// Base type for all platform-specific API attributes.
    /// </summary>
    [ExcludeFromCodeCoverage]
#if SYSTEM_PRIVATE_CORELIB
    public
#else
    internal
#endif
    abstract class OSPlatformAttribute : Attribute
    {
        private protected OSPlatformAttribute(string platformName)
        {
            PlatformName = platformName;
        }

        public string PlatformName { get; }
    }

    /// <summary>
    /// Records the platform that the project targeted.
    /// </summary>
    [AttributeUsage(AttributeTargets.Assembly, AllowMultiple = false, Inherited = false)]
    [ExcludeFromCodeCoverage]
#if SYSTEM_PRIVATE_CORELIB
    public
#else
    internal
#endif
    sealed class TargetPlatformAttribute : OSPlatformAttribute
    {
        public TargetPlatformAttribute(string platformName) : base(platformName) { }
    }

    /// <summary>
    /// Records the operating system (and minimum version) that supports an API. Multiple attributes can be
    /// applied to indicate support on multiple operating systems.
    /// </summary>
    /// <remarks>
    /// Callers can apply a <see cref="System.Runtime.Versioning.SupportedOSPlatformAttribute " />
    /// or use guards to prevent calls to APIs on unsupported operating systems.
    ///
    /// A given platform should only be specified once.
    /// </remarks>
    [AttributeUsage(
        AttributeTargets.Assembly
            | AttributeTargets.Class
            | AttributeTargets.Constructor
            | AttributeTargets.Enum
            | AttributeTargets.Event
            | AttributeTargets.Field
            | AttributeTargets.Method
            | AttributeTargets.Module
            | AttributeTargets.Property
            | AttributeTargets.Struct,
        AllowMultiple = true,
        Inherited = false
    )]
    [ExcludeFromCodeCoverage]
#if SYSTEM_PRIVATE_CORELIB
    public
#else
    internal
#endif
    sealed class SupportedOSPlatformAttribute : OSPlatformAttribute
    {
        public SupportedOSPlatformAttribute(string platformName) : base(platformName) { }
    }

    /// <summary>
    /// Marks APIs that were removed in a given operating system version.
    /// </summary>
    /// <remarks>
    /// Primarily used by OS bindings to indicate APIs that are only available in
    /// earlier versions.
    /// </remarks>
    [AttributeUsage(
        AttributeTargets.Assembly
            | AttributeTargets.Class
            | AttributeTargets.Constructor
            | AttributeTargets.Enum
            | AttributeTargets.Event
            | AttributeTargets.Field
            | AttributeTargets.Method
            | AttributeTargets.Module
            | AttributeTargets.Property
            | AttributeTargets.Struct,
        AllowMultiple = true,
        Inherited = false
    )]
    [ExcludeFromCodeCoverage]
#if SYSTEM_PRIVATE_CORELIB
    public
#else
    internal
#endif
    sealed class UnsupportedOSPlatformAttribute : OSPlatformAttribute
    {
        public UnsupportedOSPlatformAttribute(string platformName) : base(platformName) { }
    }
}
#else
#error Platform not supported
#endif
