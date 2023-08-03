namespace Bofa;
enum eErrorType
{
	UnexpectedContentError, //There is content that shouldnt be where it is
	UnexpectedEndOfContentError, //The content ends when it should not
	TypeConversionError, //The input cannot be parsed to its intended type
	IntendationError, //The user has indented when they shouldnt have
}