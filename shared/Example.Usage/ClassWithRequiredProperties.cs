namespace Example.Usage;

internal sealed class ClassWithRequiredProperties
{
    public required int Id { get; set; }

    public int GetId() => Id;
}
