namespace Bofa;

struct bofa_error
{
	public bofa_error_type error_type;
	public uint64 line;
}

enum bofa_error_type
{
	UnexpectedEndOfContent //Content ends when we would have expected it to go on for longer
}