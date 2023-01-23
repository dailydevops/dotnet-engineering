#if NET7_0_OR_GREATER
[assembly: System.Runtime.CompilerServices.TypeForwardedTo(typeof(System.Runtime.CompilerServices.CompilerFeatureRequiredAttribute))]
[assembly: System.Runtime.CompilerServices.TypeForwardedTo(typeof(System.Runtime.CompilerServices.RequiredMemberAttribute))]
#elif NET47 || NET471_OR_GREATER || NETSTANDARD1_0_OR_GREATER || NETCOREAPP1_0_OR_GREATER
#pragma warning disable
// Licensed to the .NET Foundation under one or more agreements.
// The .NET Foundation licenses this file to you under the MIT license.

namespace System.Runtime.CompilerServices;

using System;
using System.Diagnostics.CodeAnalysis;

/// <summary>
/// Indicates that compiler support for a particular feature is required for the location where this attribute is applied.
/// </summary>
[AttributeUsage(AttributeTargets.All, AllowMultiple = true, Inherited = false)]
[ExcludeFromCodeCoverage]
[CompilerGenerated]
internal sealed class CompilerFeatureRequiredAttribute : Attribute
{
    /// <summary>
    /// Creates a new instance of the <see cref="Runtime.CompilerServices.CompilerFeatureRequiredAttribute"/> type.
    /// </summary>
    /// <param name="featureName">The name of the feature to indicate.</param>
    public CompilerFeatureRequiredAttribute(string featureName)
    {
        FeatureName = featureName;
    }

    /// <summary>
    /// The name of the compiler feature.
    /// </summary>
    public string FeatureName { get; }

    /// <summary>
    /// If true, the compiler can choose to allow access to the location where this attribute is applied if it does not understand <see cref="FeatureName"/>.
    /// </summary>
    public bool IsOptional { get; set; }

    /// <summary>
    /// The <see cref="FeatureName"/> used for the ref structs C# feature.
    /// </summary>
    public const string RefStructs = nameof(RefStructs);

    /// <summary>
    /// The <see cref="FeatureName"/> used for the required members C# feature.
    /// </summary>
    public const string RequiredMembers = nameof(RequiredMembers);
}

/// <summary>
/// Specifies that a type has required members or that a member is required.
/// </summary>
[AttributeUsage(
    AttributeTargets.Class |
    AttributeTargets.Struct |
    AttributeTargets.Field |
    AttributeTargets.Property,
    AllowMultiple = false,
    Inherited = false)]
[ExcludeFromCodeCoverage]
[CompilerGenerated]
internal sealed class RequiredMemberAttribute : Attribute
{
}
#endif
