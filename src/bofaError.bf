namespace Bofa;

struct bofa_error
{
	public bofa_error_type error_type;
	public uint64 line;

	public this(bofa_error_type pErrorType, uint64 pLine)
	{
		error_type = pErrorType;
		line = pLine;
	}
}

enum bofa_error_type
{
	UnexpectedEndOfContent, //Content ends when we would have expected it to go on for longer
	EndOfContent, //The content ends
	UnexpectedSpace, //Administrative decision to disallow spaces for indenting
	TooMuchIndentation,
	UnexpectedTab
}