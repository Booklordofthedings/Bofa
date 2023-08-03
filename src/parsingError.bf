namespace Bofa;
struct parsingError
{
	public uint64 line;
	public eErrorType type;

	public override void ToString(System.String strBuffer)
	{
		strBuffer.Append(scope $"{type.ToString(.. scope .())} on line: {line.ToString(.. scope .())}");
	}
}