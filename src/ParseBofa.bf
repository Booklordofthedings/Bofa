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
			{
				toReturn.Cleanup();
				return .Err(.(err, line));
			}
			l = getDepth.Value.1;
			int depth = getDepth.Value.0;

			let getName = ParseBofaGetName(l);
			if(getName case .Err(let err))
			{
				toReturn.Cleanup();
				return .Err(.(err, line));
			}	
			l = getName.Value.1;
			StringView name = getName.Value.0;

			Console.WriteLine(scope $"""
				New Line:
				depth: {depth}
				name: {name}
				""");
			/*
				if name == "-" //Array entry
				if name == "->" //Add to last text if it exists
				otherwise continue normally
			*/
			let getType = ParseBofaGetTypeAndTypeName(l);
			if(getType case .Err(let err))
			{
				toReturn.Cleanup();
				return .Err(.(err, line));
			}
			bofa_type type = getType.Value.0;
			StringView type_name = getType.Value.1;
			StringView value = getName.Value.1; //Now l is equal to value
			/*
			==============================================
			All data is now known we only need to parse/create it in
			*/

			Console.WriteLine(scope $"""
				depth: {depth}
				type_name: {type_name}
				value: {value}

				-End of object-
				""");

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
		return .Err(.UnexpectedEndOfContent);
	}

	///Input a line and return an error or the name of the bofa entry and the rest of the line
	private static Result<(StringView, StringView), bofa_error_type> ParseBofaGetName(StringView pLine)
	{
		for(int i = 0; i < pLine.Length; i++)
		{
			if(pLine[i] == '\t')
				return .Err(.UnexpectedTab);
			else if(pLine[i] == ' ')
				return .Ok((
					StringView(pLine,0,i), //Name
					StringView(pLine, i) //Rest of the string
				));
				
		}
		return .Err(.UnexpectedEndOfContent);
	}

	//Return the type, typename and move the string view towards the first letter of the value
	private static Result<(bofa_type, StringView, StringView),bofa_error_type> ParseBofaGetTypeAndTypeName(StringView pLine)
	{
		//Its easier to move this manually
		StringView line = pLine;
		if(pLine.Length > 1 && pLine[0] == ' ')
		{
			line = .(line,1);
			if(line[0] == ' ')
				return .Err(.TooMuchIndentation);
		}


		bofa_type type;
		StringView type_name = "";
		for(int i = 0; i < line.Length; i++)
		{
			if(line[i].IsWhiteSpace)
			{
				if(line[i] != ' ')
					return .Err(.UnexpectedTab); //Technically something other than a tab aswell, but that doesnt matter to us

				switch(StringView(line,0,i))
				{
				case "n":
					type = .number;
					type_name = "number";
				case "b":
					type = .boolean;
					type_name = "boolean";
				case "bn":
					type = .big_number;
					type_name = "big_number";
				case "i":
					type = .integer;
					type_name = "integer";
				case "bi":
					type = .big_integer;
					type_name = "big_integer";
				case "l":
					type = .line;
					type_name = "line";
				case "t":
					type = .text;
					type_name = "text";
				case "a":
					type = .array;
					type_name = "array";
				case "o":
					type = .object;
					type_name = "object";
				case "c":
					type = .custom;
				default:
					type = .number;
					type_name = "ERORR";
					return .Err(.InvalidType);
				}
				line = .(line,i,line.Length-i);

				if(type != .custom)
					return .Ok((type, type_name, line));
				//We have mow found the type, and already returned, if its a custom we still need to figure it our

				if(line.Length > 1 && line[0] == ' ')
				{
					line = .(line,1);
					if(line[0] == ' ')
						return .Err(.TooMuchIndentation);
				}

				for(int ii = 0; ii < line.Length; ii++)
				{
					if(line[ii].IsWhiteSpace)
					{
						if(line[ii] != ' ')
							return .Err(.UnexpectedTab);

						type_name = .(line,0,ii);
						line = .(line,ii);
						if(line.Length <= 1)
							return .Err(.UnexpectedEndOfContent);
						line = .(line,1); //Makes it easier to parse content
						return .Ok((type, type_name, line));

					}
				}

				
			}
		}
		return .Err(.UnexpectedEndOfContent);
	}

}