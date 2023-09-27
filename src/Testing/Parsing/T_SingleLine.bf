namespace Bofa.Testing.Parsing;
using System;
using Bofa;
using Bofa.Builder;
class T_SingleLine
{
	/*
		This class checks the validity of any single line bofa object
	*/

	[Test] //Any line that should be parsed as empty
	public static void EmptyLine()
	{
		StringView[] lineArr = scope .(
			"",
			" ",
			"\t",
			"    	",
			"#asdasdasdasd",
			"     # asdasdasdasd",
			"#"
			);

		BofaParser p = .();
		for(let e in lineArr)
		{
			var r = p.[Friend]parseLine(e);
			if(!r.IsEmpty)
				Runtime.FatalError();
		}
	}

	[Test] //Some lines that should be parsed as text
	public static void Text()
	{
		StringView[] lineArr = scope .(
			"- text", //Depth 0
			" - text", //Depth 1
			"  - TEasdasdas iodfjoidfiosduiofsd", //Depth 2
			" 	 - dadsadasdasdasfjrdfiofjiofdsghjniodfgdf" //Depth 3
			);
		BofaParser p = .();
		for(int i < lineArr.Count)
		{
			var r = p.[Friend]parseLine(lineArr[i]);
			if(!r.Ok || r.IsEmpty)
				Runtime.FatalError();

			if(r.Text.0 != i+1)
				Runtime.FatalError();
		}
	}

	[Test] //Doing some parsing
	public static void Parse()
	{
		StringView[] lineArr = scope .(
			"n float 1223",
			"n float 1.232",
			"b bool true",
			"b bool false",
			"l line text goes here",
			"bn BigNumber 3242343242354543",
			"i integer 12423423",
			"bi BigInteger 344234323454365",
			"t text sdfsdgdfgdfgdf",
			"t text ",
			"c color redd 255 0 0",
			"a array",
			"o object"
			);
		BofaParser p = .();
		for(var e in lineArr)
		{
			var r = p.[Friend]parseLine(e);
			if(!r.Ok || r.IsEmpty || !r.IsBofa)
				Runtime.FatalError();
			delete r.Bofa.1;
		}
	}
}