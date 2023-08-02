namespace Bofa;
using System;
static
{
	///Parse an input string into a bofy type object
	public static Result<bofa, bofa_error> ParseBofa(StringView pToParse)
	{
		bofa toReturn = .();
		toReturn.[Friend]stored = new .(pToParse);
		toReturn.name = "";
		toReturn.type = .object;
		toReturn.type_name = "object";
		toReturn.value.object = new .(50);

		uint64 line = 0;
		var enumerator = toReturn.[Friend]stored.Split('\n', StringSplitOptions.None);
		for(var l in enumerator)
		{
			let getDepth = ParseBofaGetDepth(l);
			if(getDepth case .Err(let err))
				return .Err(.(err, line));
			l = getDepth.Value.1;
			int depth = getDepth.Value.0;

			let getName = ParseBofaGetName(l);
			if(getName case .Err(let err))
				return .Err(.(err, line));
			l = getName.Value.1;
			StringView name = getName.Value.0;

			/*
				if name == "-" //Array entry
				if name == "->" //Add to last text if it exists
				otherwise continue normally
			*/
			
			line++;
		}
		

		return .Ok(toReturn);
	}

	///Input a line and return the amount of tabs before the first content and the rest of the line
	private static Result<(int, StringView), bofa_error_type> ParseBofaGetDepth(StringView pLine)
	{
		for(int i = 0; i < pLine.Length; i++)
		{
			if(pLine[i] == '\t')
				continue; //This will just count up
			else if(pLine[i] == ' ')
				return .Err(.UnexpectedSpace);
			else //Return a new one that works
				return .Ok((i, .(pLine, i)));
		}
		return .Err(.EndOfContent);
	}

	///Input a line and return an error or the name of the bofa entry and the rest of the line
	private static Result<(StringView, StringView), bofa_error_type> ParseBofaGetName(StringView pLine)
	{
		for(int i = 0; i < pLine.Length; i++)
		{
			if(pLine[i] == '\t')
				return .Err(.UnexpectedTab);
			if(pLine[i] == ' ')
				return .Ok((
					StringView(pLine,0,i), //Name
					StringView(pLine, i) //Rest of the string
				));
				
		}
		return .Err(.EndOfContent);
	}

	//Return the type, typename and move the string view towards the first letter of the value
	private static Result<(bofa_type, StringView, StringView),bofa_error_type> ParseBofaGetTypeAndTypeName(StringView pLine)
	{
		for(int i = 0; i < pLine.Length; i++)
			Console.WriteLine("asdasdsad");
		return .Err(.UnexpectedEndOfContent);
	}

}